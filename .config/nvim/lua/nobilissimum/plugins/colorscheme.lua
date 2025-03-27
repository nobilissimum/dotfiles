return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            color_overrides = {
                all = {
                    text = Colors.white,
                },
            },
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

        vim.api.nvim_set_hl(0, "FidgetComment", { bg = Colors.hush.light })
        vim.api.nvim_set_hl(0, "FidgetComment", { fg = Colors.white })

        vim.api.nvim_set_hl(0, "Identifier", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "Todo", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "@lsp.type.interface", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "@symbol", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "@symbol.ruby", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "@text.todo", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "@string.special.symbol", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "@string.special.symbol.ruby", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "@constructor.lua", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "MiniStarterSection", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "BlinkCmpKindSnippet", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "BlinkCmpKindVariable", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "NvimTreeSpecialFile", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "markdownCodeBlock", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "markdownCode", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "mkdCodeEnd", { fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "mkdCodeStart", { fg = Colors.cyan })
    end,
}
