return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            transparent_background = true,
            styles = {
                comments = { "italic" },
            },
        })

        -- Theme
        vim.opt.termguicolors = true
        vim.cmd.colorscheme("catppuccin")

        -- Ghost characters
        vim.api.nvim_set_hl(0, "Whitespace", { fg = GhostCharacterColor })
        vim.api.nvim_set_hl(0, "NonText", { fg = GhostCharacterColor })
        vim.api.nvim_set_hl(0, "SpecialKey", { fg = GhostCharacterColor })


        -- Cursor line
        vim.opt.cursorline = true
        vim.api.nvim_set_hl(0, "CursorLine", { bg = NumberLineColor })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = NumberLineColor, fg = "#eeeeee" })
        vim.api.nvim_set_hl(0, "CursorLineSign", { bg = NumberLineColor })
    end,
}
