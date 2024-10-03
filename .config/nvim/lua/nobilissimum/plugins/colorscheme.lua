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

        local number_line_bg = "#121c26"
        vim.api.nvim_set_hl(0, "CursorLine", { bg = number_line_bg })
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = number_line_bg, fg = "#eeeeee" })
        vim.api.nvim_set_hl(0, "CursorLineSign", { bg = number_line_bg })
    end,
}
