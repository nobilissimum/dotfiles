return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = {
        "echasnovski/mini.icons",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local snacks = require("snacks")
        vim.keymap.set('n', '<leader>hb', snacks.git.blame_line, { desc = "Git [b]lame line" })
    end,
}
