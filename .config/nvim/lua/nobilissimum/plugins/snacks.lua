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
        local keys = {}

        local sections_padding = 2
        local sections_padding_multiplier = 1
        if #keys >= 1 then
            sections_padding_multiplier = sections_padding_multiplier + 1
        end

        local margin = 6
        local base_window_height = 50
        local terminal_height = math.min(
            (
                (vim.api.nvim_win_get_height(0) - (vim.o.showtabline > 0 and 1 or 0)) - -- window height
                #keys -
                (sections_padding * 2) - -- #sections - 1 = 2
                (margin * 2) + -- top and bottom
                2 -- statusline and commandline
            ),
            base_window_height
        )

        local terminal_width = math.floor(terminal_height * 2.5)

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
                        width = terminal_width,
                        indent = math.floor((keys_width - terminal_width) / 2),
                        padding = sections_padding,
                    },
                    { section = "startup" },
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

                vim.api.nvim_err_writeln = function(msg)
                    vim.notify(msg, vim.log.levels.ERROR, {
                        title = "Neovim Error",
                        timeout = 60000,
                        background_color = "NONE",
                    })
                end
            end,
        })
    end,
}
