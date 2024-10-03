return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local padding = "     "
        require("gitsigns").setup({
            signs = {
                add = { text = "▌" },
                change = { text = "▌" },
            },
            signs_staged = {
                add = { text = "▌" },
                change = { text = "▌" },
            },
            culhl = true,
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 0,
                ignore_whitespace = true,
                use_focus = true,
            },
            current_line_blame_formatter_nc = padding .. "Uncommitted change",
            current_line_blame_formatter = padding .. "<abbrev_sha> • <author> • <author_time:%R> - <author_time:%Y%m%d:%H%M%S> • <summary>",
        })

        local add_color = "#65a884"
        vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = add_color, bold = true })
        vim.api.nvim_set_hl(0, "GitSignsAddCul", { fg = add_color, bg = NumberLineColor, bold = true })

        local change_color = "#74add2"
        vim.api.nvim_set_hl(0, "GitSignsChange", { fg = change_color, bold = true })
        vim.api.nvim_set_hl(0, "GitSignsChangeCul", { fg = change_color, bg = NumberLineColor, bold = true })

        local delete_color = "#f77172"
        vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = delete_color, bold = true })
        vim.api.nvim_set_hl(0, "GitSignsDeleteCul", { fg = delete_color, bg = NumberLineColor, bold = true })

        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = GhostCharacterColor })
    end,
}
