return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup()

        vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#65a884", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#74add2", bold = true })
        vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#f77172", bold = true })
    end,
}
