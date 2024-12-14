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
        local keys_gap = 1
        local keys = {
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
        }

        local sections_padding = 2
        local margin = 6
        local base_window_height = 25
        local terminal_height = math.min(
            (
                (vim.api.nvim_win_get_height(0) - (vim.o.showtabline > 0 and 1 or 0)) - -- window height
                (#keys * (keys_gap + 1)) -
                (sections_padding * 2) - -- #sections - 1 = 2
                (margin * 2) + -- top and bottom
                2 -- statusline and commandline
            ),
            base_window_height
        )

        local terminal_width = math.floor(terminal_height * 2.4)

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
                preset = { keys = keys },
                sections = {
                    {
                        section = "terminal",
                        cmd = "output=$(ascii-image-converter -C -c ~/dotfiles/neovim.png -d " .. terminal_width .. "," .. terminal_height .. ') && echo -e "$output\n$output"',
                        height = terminal_height,
                        indent = math.floor((keys_width - terminal_width) / 2),
                        padding = sections_padding,
                    },
                    { section = "startup", padding = sections_padding },
                    { section = "keys", gap = keys_gap },
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
