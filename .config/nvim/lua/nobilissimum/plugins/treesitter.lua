return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")

        -- Preinstalled on first launch; install() skips anything already present
        ts.install({
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
        })

        local installing = {} -- avoid duplicate installs for the same language
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local buf = args.buf
                local lang = vim.treesitter.language.get_lang(args.match)
                if not lang then return end

                if vim.list_contains(ts.get_installed(), lang) then
                    pcall(vim.treesitter.start, buf)
                    return
                end

                if installing[lang] or not vim.list_contains(ts.get_available(), lang) then
                    return
                end

                installing[lang] = true
                vim.notify("Installing treesitter parser: " .. lang, vim.log.levels.INFO)
                ts.install(lang):await(function()
                    installing[lang] = nil
                    vim.schedule(function()
                        if vim.api.nvim_buf_is_valid(buf)
                            and vim.list_contains(ts.get_installed(), lang) then
                            pcall(vim.treesitter.start, buf)
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
