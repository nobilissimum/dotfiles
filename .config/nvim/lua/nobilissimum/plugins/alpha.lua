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

        vim.api.nvim_set_hl(0, "DashboardHeaderNE", { bg = Colors.blue, fg = Colors.magenta })
        vim.api.nvim_set_hl(0, "DashboardHeaderOV", { bg = Colors.green, fg = Colors.cyan })
        vim.api.nvim_set_hl(0, "DashboardHeaderVI", { bg = Colors.yellow, fg = Colors.green })

        vim.api.nvim_set_hl(0, "DashboardFooterPlugins", { bg = nil, fg = Colors.yellow })
        vim.api.nvim_set_hl(0, "DashboardFooterPlatform", { bg = nil, fg = Colors.blue })
        vim.api.nvim_set_hl(0, "DashboardFooterVersion", { bg = nil, fg = Colors.green })

        -- _______                   ___        
        -- ██████  ____  ______  __▀▀▀ _____  
        -- ███▐████▀▀███████████████ 
        --████▐████████████████████████
        --████▐█████▄▄▄▄████ █ █████ █ ██
        --                                

        dashboard.section.header = {
            type = "group",
            val = {
                {
                    type = "text",
                    val = " _______                   ___        ",
                    opts = {
                        hl = {
                            { "DashboardHeaderN", 1, 8 },
                            { "DashboardHeaderI", 27, 30 },
                        },
                        position = "center",
                    },
                },
                {
                    type = "text",
                    val = " ██████  ____  _______  _▀▀▀ _____  ",
                    opts = {
                        hl = {
                            { "DashboardHeaderN", 1, 26 },
                            { "DashboardHeaderE", 27, 31 },
                            { "DashboardHeaderO", 33, 37 },
                            { "DashboardHeaderV", 37, 43 },
                            { "DashboardHeaderI", 43, 52 },
                            { "DashboardHeaderM", 53, 58 },
                        },
                        position = "center",
                    },
                },
                {
                    type = "text",
                    val = " ███▐████▀▀███████████████ ",
                    opts = {
                        hl = {
                            { "DashboardHeaderN", 1, 27 },
                            { "DashboardHeaderE", 27, 44 },
                            { "DashboardHeaderO", 44, 61 },
                            { "DashboardHeaderOV", 61, 63 },
                            { "DashboardHeaderV", 63, 78 },
                            { "DashboardHeaderVI", 78, 80 },
                            { "DashboardHeaderI", 80, 86 },
                            { "DashboardHeaderM", 86, 107 },
                        },
                        position = "center",
                    },
                },
                {
                    type = "text",
                    val = "████▐████████████████████████",
                    opts = {
                        hl = {
                            { "DashboardHeaderN", 0, 28 },
                            { "DashboardHeaderE", 28, 46 },
                            { "DashboardHeaderO", 46, 64 },
                            { "DashboardHeaderV", 64, 79 },
                            { "DashboardHeaderI", 79, 88 },
                            { "DashboardHeaderM", 88, 112 },
                        },
                        position = "center",
                    },
                },
                {
                    type = "text",
                    val = "████▐█████▄▄▄▄████ █ █████ █ ██",
                    opts = {
                        hl = {
                            { "DashboardHeaderN", 0, 28 },
                            { "DashboardHeaderNE", 28, 31 },
                            { "DashboardHeaderE", 31, 46 },
                            { "DashboardHeaderO", 46, 64 },
                            { "DashboardHeaderV", 65, 75 },
                            { "DashboardHeaderI", 75, 84 },
                            { "DashboardHeaderM", 84, 104 },
                        },
                        position = "center",
                    },
                },
                {
                    type = "text",
                    val = "                                ",
                    opts = {
                        hl = {
                            { "DashboardHeaderN", 8, 14 },
                            { "DashboardHeaderE", 18, 24 },
                            { "DashboardHeaderM", 43, 49 },
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
        local footer = string.format("󰂖 %d  %s  v%d.%d.%d", plugins, platform, version.major, version.minor, version.patch)

        local plugins_length = string.len(plugins) + 5
        local platform_length = 2
        local version_length = string.len(version.major) + string.len(version.minor) + string.len(version.patch) + 4

        dashboard.section.footer = {
            type = "text",
            val = footer,
            opts = {
                hl =  {
                    { "DashboardFooterPlugins", 0, plugins_length },
                    { "DashboardFooterPlatform", plugins_length + 2, plugins_length + 2 + platform_length },
                    { "DashboardFooterVersion", plugins_length + 2 + platform_length + 2, plugins_length + 2 + platform_length + 2 + version_length },
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









