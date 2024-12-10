return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = {
        "echasnovski/mini.icons",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        Snacks = require("snacks")
        vim.keymap.set("n", "<leader>hb", Snacks.git.blame_line, { desc = "Git [b]lame line" })
        vim.keymap.set("n", "<leader>un", Snacks.notifier.hide, { desc = "Dismiss all notifications" })

        Snacks.setup({
            animate = {
                enabled = false,
            },
            bigfile = {
                enabled = true,
                notify = true,
            },
            notifier = {
                enabled = true,
                timeout = 30000,
            },
        })
    end,
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end

                _G.bt = function()
                    Snacks.debug.backtrace()
                end

                vim.print = _G.dd
            end,
        })
    end,
}
