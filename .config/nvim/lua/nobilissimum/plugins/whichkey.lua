return {
    "folke/which-key.nvim",
    dependencies = {
        "echasnovski/mini.icons",
    },
    event = "VeryLazy",
    opts = {},
    config = function()
        require("which-key").setup()
    end,
}
