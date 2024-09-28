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

        vim.opt.termguicolors = true
        vim.cmd.colorscheme("catppuccin")

        vim.opt.cursorline = true
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#121c26" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#121c26", fg = "#eeeeee" })
    end,
}
