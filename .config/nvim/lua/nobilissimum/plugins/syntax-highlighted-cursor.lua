return {
    "ukyouz/syntax-highlighted-cursor.nvim",
    config = function()
        require("syntax-highlighted-cursor").setup({})
        vim.opt.guicursor = "n-v-ve:block-Cursor/lCursor,i:hor20-Cursor/lCursor,c-ci-cr:hor20-CursorCommandline"
        vim.api.nvim_set_hl(0, "CursorCommandline", { bg = "#c0c0c0" })  -- Wezterm silver

        vim.api.nvim_create_autocmd("VimLeave", {
            callback = function()
                vim.opt.guicursor = "a:hor20"
            end,
        })
    end,
}
