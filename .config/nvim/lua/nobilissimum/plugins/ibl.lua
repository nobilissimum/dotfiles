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
    end,
}