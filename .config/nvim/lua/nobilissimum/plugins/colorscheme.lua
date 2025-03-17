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

        -- Modes
        vim.api.nvim_set_hl(0, "Visual", { bg = Colors.bright_black2, bold = true })

        -- Ghost characters
        vim.api.nvim_set_hl(0, "Whitespace", { fg = Colors.bright_black2 })
        vim.api.nvim_set_hl(0, "NonText", { fg = Colors.bright_black2 })
        vim.api.nvim_set_hl(0, "SpecialKey", { fg = Colors.bright_black2 })

        -- Cursor line
        vim.opt.cursorline = true
        vim.api.nvim_set_hl(0, "CursorLine", { bg = Colors.hush.dark })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = Colors.hush.dark, fg = Colors.white })
        vim.api.nvim_set_hl(0, "CursorLineSign", { bg = Colors.hush.dark })

        -- Popup pane
        local dark_bg = { bg = Colors.hush.dark }
        vim.api.nvim_set_hl(0, "NormalFLoat", dark_bg)
        vim.api.nvim_set_hl(0, "FloatBorder", dark_bg)

        vim.api.nvim_set_hl(0, "Pmenu", { bg = Colors.hush.light })
        vim.api.nvim_set_hl(0, "PmenuSel", { bg = Colors.hush.dark })
        vim.api.nvim_set_hl(0, "PmenuSbar", { bg = Colors.bright_black2_5 })
        vim.api.nvim_set_hl(0, "PmenuThumb", { bg = Colors.bright_black })

        vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = Colors.bright_black2_5 })
        vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { bg = Colors.bright_black2_5 })
        vim.api.nvim_set_hl(0, "BlinkCmpDocSeparator", { bg = Colors.bright_black2_5 })
        vim.api.nvim_set_hl(0, "BlinkCmpDocCursorLine", { bg = Colors.hush.dark })
    end,
}
