return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function ()
        local highlight = {
            "CursorColumn",
            "Whitespace",
        }

        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function ()
            vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#202733" })
        end)

        require("ibl").setup({
            indent = { highlight = highlight, char = "" },
            whitespace = {
                highlight = highlight,
                remove_blankline_trail = false,
            },
            scope = { enabled = false },
        })

        local vim_eol = ""
        local file_format = vim.bo.fileformat
        if file_format == "dos" then
            vim_eol = ""
        else
            vim_eol = "↓"
        end

        vim.opt.listchars = {
            eol = vim_eol,
            nbsp = "+",
            space = "·",
            tab = ">·",
            trail = "·",
        }
        vim.opt.list = true
    end,
}