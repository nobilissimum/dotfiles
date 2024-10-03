return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local padding = "     "
        require("gitsigns").setup({
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

        vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#65a884", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#74add2", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#f77172", bold = true })

        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = GhostCharacterColor }) -- #ffffff33 on #1d232e
    end,
}
