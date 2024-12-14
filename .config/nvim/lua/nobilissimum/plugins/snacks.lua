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

        vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = Colors.blue, bold = true })
        vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = Colors.blue, bold = true })
        vim.api.nvim_set_hl(0, "SnacksDashboardKey", { bg = Colors.yellow, fg = Colors.black, bold = true })

        local keys_width = 60
        local terminal = {
            width = 60,
            height = 25,
        }

        Snacks.setup({
            animate = {
                enabled = false,
            },
            bigfile = {
                enabled = true,
                notify = true,
            },
            dashboard = {
                enabled = true,
                preset = {
                    keys = {
                        {
                            text = {
                                { "  ", hl = "SnacksDashboardIcon" },
                                { "New file", hl = "SnacksDashboardDesc", width = keys_width },
                                { " n ", hl = "SnacksDashboardKey" },
                            },
                            action = ":enew",
                            key = "n",
                        },
                        {
                            text = {
                                { "  ", hl = "SnacksDashboardIcon" },
                                { "Find file", hl = "SnacksDashboardDesc", width = keys_width },
                                { " f ", hl = "SnacksDashboardKey" },
                            },
                            action = ":Telescope find_files",
                            key = "f",
                        },
                        {
                            text = {
                                { "󰒲  ", hl = "SnacksDashboardIcon" },
                                { "Lazy.nvim", hl = "SnacksDashboardDesc", width = keys_width },
                                { " l ", hl = "SnacksDashboardKey" },
                            },
                            action = ":Lazy",
                            key = "l",
                        },
                        {
                            text = {
                                { "󰽛  ", hl = "SnacksDashboardIcon" },
                                { "Mason", hl = "SnacksDashboardDesc", width = keys_width },
                                { " m ", hl = "SnacksDashboardKey" },
                            },
                            action = ":Mason",
                            key = "m",
                        },
                        {
                            text = {
                                { "  ", hl = "SnacksDashboardIcon" },
                                { "Exit neovim", hl = "SnacksDashboardDesc", width = keys_width },
                                { " q ", hl = "SnacksDashboardKey" },
                            },
                            action = function()
                                vim.notify("Wrong!", vim.log.levels.ERROR)
                            end,
                            key = "q",
                        },
                    },
                },
                sections = {
                    {
                        section = "terminal",
                        cmd = "ascii-image-converter -C -c ~/dotfiles/neovim.png -d " .. terminal.width .. "," .. terminal.height * 2,
                        height = terminal.height,
                        indent = keys_width - terminal.width,
                        padding = 2,
                    },
                    { section = "startup", padding = 2 },
                    { section = "keys", gap = 1 },
                },
            },
            notifier = {
                enabled = true,
                timeout = 10000,
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
