return {
    "goolord/alpha-nvim",
    dependencies = {
        "echasnovski/mini.icons",
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local alpha = require("alpha")
        require("alpha.term")
        local dashboard = require("alpha.themes.dashboard")

        vim.api.nvim_set_hl(0, "DashboardFooterPlugins", { bg = nil, fg = Colors.yellow })
        vim.api.nvim_set_hl(0, "DashboardFooterPlatform", { bg = nil, fg = Colors.blue })
        vim.api.nvim_set_hl(0, "DashboardFooterVersion", { bg = nil, fg = Colors.green })
        vim.api.nvim_set_hl(0, "DashboardFooterSeparator", { bg = nil, fg = Colors.bright_black2 })

        local plugins = #vim.tbl_keys(require("lazy").plugins())
        local version = vim.version()
        local platform = vim.fn.has("win32") == 1 and "" or ""
        local footer = string.format(
            "󰂖 %d • %s • v%d.%d.%d",
            plugins,
            platform,
            version.major,
            version.minor,
            version.patch
        )

        local plugins_length = string.len(plugins) + 5
        local platform_length = 3
        local version_length = string.len(version.major) + string.len(version.minor) + string.len(version.patch) + 4

        dashboard.section.buttons.val = {}
        dashboard.section.footer = {
            type = "text",
            val = footer,
            opts = {
                hl = {
                    { "DashboardFooterPlugins", 0, plugins_length },
                    { "DashboardFooterSeparator", plugins_length + 1, plugins_length + 2 },
                    { "DashboardFooterPlatform", plugins_length + 2, plugins_length + 4 + platform_length },
                    {
                        "DashboardFooterSeparator",
                        plugins_length + 6 + platform_length,
                        plugins_length + 7 + platform_length,
                    },
                    {
                        "DashboardFooterVersion",
                        plugins_length + 8 + platform_length,
                        plugins_length + 10 + platform_length + version_length,
                    },
                },
                position = "center",
            },
        }

        local win_height = vim.api.nvim_win_get_height(0) - (vim.o.showtabline > 0 and 1 or 0)

        local buttons_section_pad = 2
        buttons_section_pad = #dashboard.section.buttons.val >= 1 and buttons_section_pad or 0

        local footer_builtin_pad = 1
        local footer_section_pad = 2
        footer_section_pad = #dashboard.section.footer.val - footer_builtin_pad >= 1 and footer_section_pad or 0


        local margin = 6
        local header_max_height = 50
        local header_height = math.min(
            (
                win_height -
                (
                    #dashboard.section.buttons.val +
                    #dashboard.section.footer +
                    buttons_section_pad +
                    footer_section_pad +
                    footer_builtin_pad
                ) -
                (margin * 2) + -- top and bottom
                2 -- statusline and commandline
            ),
            header_max_height
        )
        local header_width = math.floor(header_height * 2.5)
        dashboard.section.header = {
            type = "terminal",
            command = "$HOME/.scripts/nvim-dash.sh " .. header_width .. " " .. header_height,
            val = F.empty_table(header_height),
            width = header_width,
            height = header_height,
            opts = {
                redraw = true,
            },
        }

        local padding_lines = math.floor(
            (win_height - (
                #dashboard.section.header.val +
                (#dashboard.section.buttons.val * 2) +
                buttons_section_pad +
                footer_section_pad
            )) / 2
        ) + 1
        dashboard.config.layout = {
            { type = "padding", val = padding_lines },
            dashboard.section.header,
            { type = "padding", val = buttons_section_pad },
            dashboard.section.buttons,
            { type = "padding", val = footer_section_pad },
            dashboard.section.footer,
        }

        alpha.setup(dashboard.config)
        require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
}
