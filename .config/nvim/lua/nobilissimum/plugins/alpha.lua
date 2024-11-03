return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
         local alpha = require("alpha")
         local dashboard = require("alpha.themes.dashboard")

        vim.api.nvim_set_hl(0, "DashboardHeader", { bg = nil, fg = Colors.white })
        vim.api.nvim_set_hl(0, "DashboardFooter", { bg = nil, fg = Colors.yellow })

        vim.api.nvim_set_hl(0, "DashboardHeaderN", { bg = nil, fg = Colors.magenta })
        vim.api.nvim_set_hl(0, "DashboardHeaderE", { bg = nil, fg = Colors.blue })
        vim.api.nvim_set_hl(0, "DashboardHeaderO", { bg = nil, fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "DashboardHeaderV", { bg = nil, fg = Colors.green })
        vim.api.nvim_set_hl(0, "DashboardHeaderI", { bg = nil, fg = Colors.yellow })
        vim.api.nvim_set_hl(0, "DashboardHeaderM", { bg = nil, fg = Colors.red })

        vim.api.nvim_set_hl(0, "DashboardHeaderNAlt", { bg = Colors.magenta, fg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "DashboardHeaderEAlt", { bg = Colors.blue, fg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "DashboardHeaderOAlt", { bg = Colors.cyan, fg = Colors.hush.main })
        vim.api.nvim_set_hl(0, "DashboardHeaderMAlt", { bg = Colors.red, fg = Colors.hush.main })

        vim.api.nvim_set_hl(0, "DashboardHeaderNE", { bg = Colors.blue, fg = Colors.magenta })
        vim.api.nvim_set_hl(0, "DashboardHeaderEO", { bg = Colors.cyan, fg = Colors.blue })
        vim.api.nvim_set_hl(0, "DashboardHeaderOV", { bg = Colors.green, fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "DashboardHeaderVI", { bg = Colors.yellow, fg = Colors.green })
        vim.api.nvim_set_hl(0, "DashboardHeaderIM", { bg = Colors.red, fg = Colors.yellow })

        vim.api.nvim_set_hl(0, "DashboardFooterPlugins", { bg = nil, fg = Colors.yellow })
        vim.api.nvim_set_hl(0, "DashboardFooterPlatform", { bg = nil, fg = Colors.blue })
        vim.api.nvim_set_hl(0, "DashboardFooterVersion", { bg = nil, fg = Colors.green })
        vim.api.nvim_set_hl(0, "DashboardFooterSeparator", { bg = nil, fg = Colors.bright_black2 })


        --   █▌ █               █        
        --  ██▌█████████▌ █████████
        -- █▐████▄██ ██▌███ █ █
        --█ ▐███████████████ █ █ 

        dashboard.section.header = {
            type = "group",
            val = {
                {
                    type = "text",
                    val = "   █▌ █               █        ",
                    opts = {
                        hl = {
                            { "DashboardHeaderN", 3, 22 },
                            { "DashboardHeaderI", 37, 46 },
                        },
                        position = "center",
                    },
                },
                {
                    type = "text",
                    val = "  ██▌█████████▌ █████████",
                    opts = {
                        hl = {
                            { "DashboardHeaderN", 2, 20 },
                            { "DashboardHeaderNE", 20, 23 },
                            { "DashboardHeaderE", 23, 35 },
                            { "DashboardHeaderO", 35, 50 },
                            { "DashboardHeaderOV", 50, 53 },
                            { "DashboardHeaderV", 53, 66 },
                            { "DashboardHeaderVI", 66, 69 },
                            { "DashboardHeaderI", 69, 72 },
                            { "DashboardHeaderIM", 72, 75 },
                            { "DashboardHeaderM", 75, 102 },
                        },
                        position = "center",
                    },
                },
                {
                    type = "text",
                    val = " █▐█████ ██▌███ █ █",
                    opts = {
                        hl = {
                            { "DashboardHeaderN", 1, 19 },
                            { "DashboardHeaderNE", 19, 22 },
                            { "DashboardHeaderE", 22, 34 },
                            { "DashboardHeaderEO", 34, 37 },
                            { "DashboardHeaderO", 37, 49 },
                            { "DashboardHeaderOV", 49, 52 },
                            { "DashboardHeaderV", 52, 64 },
                            { "DashboardHeaderVI", 64, 67 },
                            { "DashboardHeaderI", 67, 70 },
                            { "DashboardHeaderIM", 70, 73 },
                            { "DashboardHeaderM", 73, 99 },
                        },
                        position = "center",
                    },
                },
                {
                    type = "text",
                    val = "█ ▐███████████████ █ █ ",
                    opts = {
                        hl = {
                            { "DashboardHeaderN", 0, 19 },
                            { "DashboardHeaderE", 19, 37 },
                            { "DashboardHeaderEO", 37, 40 },
                            { "DashboardHeaderO", 40, 52 },
                            { "DashboardHeaderV", 52, 64 },
                            { "DashboardHeaderVI", 64, 67 },
                            { "DashboardHeaderI", 67, 70 },
                            { "DashboardHeaderIM", 70, 73 },
                            { "DashboardHeaderM", 73, 99 },
                        },
                        position = "center",
                    },
                },
            },
        }

        dashboard.section.buttons.val = {}

        local plugins = #vim.tbl_keys(require("lazy").plugins())
        local version = vim.version()
        local platform = vim.fn.has("win32") == 1 and "" or ""
        local footer = string.format("󰂖 %d • %s • v%d.%d.%d", plugins, platform, version.major, version.minor, version.patch)

        local plugins_length = string.len(plugins) + 5
        local platform_length = 3
        local version_length = string.len(version.major) + string.len(version.minor) + string.len(version.patch) + 4

        dashboard.section.footer = {
            type = "text",
            val = footer,
            opts = {
                hl =  {
                    { "DashboardFooterPlugins", 0, plugins_length },
                    { "DashboardFooterSeparator", plugins_length + 1, plugins_length + 2 },
                    { "DashboardFooterPlatform", plugins_length + 2, plugins_length + 4 + platform_length },
                    { "DashboardFooterSeparator", plugins_length + 6 + platform_length, plugins_length + 7 + platform_length },
                    { "DashboardFooterVersion", plugins_length + 8 + platform_length, plugins_length + 10 + platform_length + version_length },
                },
                position = "center",
            },
        }

        -- local win_height = vim.api.nvim_win_get_height(0) - (vim.o.showtabline > 0 and 1 or 0)
        local win_height = vim.api.nvim_get_option("lines") - vim.api.nvim_get_option("cmdheight")
        local padding_lines = math.floor((win_height - (#dashboard.section.header.val + (#dashboard.section.buttons.val * 2))) / 2) + 1
        dashboard.config.layout = {
            { type = "padding", val = padding_lines },
            dashboard.section.header,
            { type = "padding", val = 1 },
            dashboard.section.buttons,
            dashboard.section.footer,
        }

        alpha.setup(dashboard.config)
        vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
}









