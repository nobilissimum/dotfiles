return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")

        local preinstall = {
            "bash",
            "c",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "rust",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "yaml",
        }

        local installing = {}
        for _, l in ipairs(preinstall) do installing[l] = true end

        local function attach(lang)
            pcall(function()
                local get = vim.treesitter.query.get --[[@as table]]
                if get.clear then get:clear() end
            end)

            local ok, err = pcall(vim.treesitter.language.add, lang)
            if not ok then
                vim.notify("Treesitter: could not load parser " .. lang .. ": " .. tostring(err), vim.log.levels.ERROR)
                return
            end

            for _, b in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(b)
                    and vim.treesitter.language.get_lang(vim.bo[b].filetype) == lang
                then
                    pcall(vim.treesitter.stop, b)
                    local started, serr = pcall(vim.treesitter.start, b, lang)
                    if not started then
                        vim.notify("Treesitter: failed to start for " .. lang .. ": " .. tostring(serr), vim.log.levels.WARN)
                    end
                end
            end
        end

        ts.install(preinstall):await(function()
            vim.schedule(function()
                for _, l in ipairs(preinstall) do
                    installing[l] = nil
                    if vim.list_contains(ts.get_installed(), l) then attach(l) end
                end
            end)
        end)

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match)
                if not lang then return end

                if vim.list_contains(ts.get_installed(), lang) then
                    attach(lang)
                    return
                end

                if installing[lang] or not vim.list_contains(ts.get_available(), lang) then
                    return
                end

                installing[lang] = true
                vim.notify("Installing treesitter parser: " .. lang, vim.log.levels.INFO)
                ts.install(lang):await(function()
                    vim.schedule(function()
                        installing[lang] = nil
                        if vim.list_contains(ts.get_installed(), lang) then
                            attach(lang)
                            vim.notify("Installed treesitter parser: " .. lang, vim.log.levels.INFO)
                        else
                            vim.notify("Failed to install parser: " .. lang, vim.log.levels.ERROR)
                        end
                    end)
                end)
            end,
        })
    end,
}
