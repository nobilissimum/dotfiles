return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local colors = {
            fg = "#eeeeee",
            bg = "#121C26",

            black = "#000000",
            red = "#f77172",
            green = "#65a884",
            yellow = "#cec999",
            blue = "#74add2",
            magenta = "#a980c4",
            cyan = "#2d949f",
            white = "#eeeeee",

            bright_black = "#203a4a",
            bright_black2 = "#1e2a36",

            hush_main = "#1D232E",
        }

        local hush_theme = {
            normal = {
                a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bright_black },
                c = { fg = colors.fg, bg = colors.bright_black2 },
                x = { fg = colors.fg, bg = colors.bright_black },
                y = { fg = colors.fg, bg = colors.bright_black2 },
            },
            command = {
                a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bright_black },
                x = { fg = colors.fg, bg = colors.bright_black },
                y = { fg = colors.fg, bg = colors.bright_black2 },
            },
            insert = {
                a = { fg = colors.bg, bg = colors.green, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bright_black },
                x = { fg = colors.fg, bg = colors.bright_black },
                y = { fg = colors.fg, bg = colors.bright_black2 },
            },
            visual = {
                a = { fg = colors.bg, bg = colors.magenta, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bright_black },
                x = { fg = colors.fg, bg = colors.bright_black },
                y = { fg = colors.fg, bg = colors.bright_black2 },
            },
            replace = {
                a = { fg = colors.bg, bg = colors.red, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bright_black },
                x = { fg = colors.fg, bg = colors.bright_black },
                y = { fg = colors.fg, bg = colors.bright_black2 },
            },
            inactive = {
                a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bg },
                c = { fg = colors.fg, bg = colors.bg },
                x = { fg = colors.fg, bg = colors.bg },
                y = { fg = colors.fg, bg = colors.bg },
            },
        }

        local separator_left = ""
        local separator_right = ""
        local separators = { left = separator_left, right = separator_right }

        require("lualine").setup({
            options = {
                theme = hush_theme,
                component_separators = { left = '•', right = '•'},
                section_separators = { left = separator_right, right = separator_left },
                globalstatus = true,
            },
            sections = {
                lualine_a = {{ "mode", separator = { right = separator_right } } },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = {
                    {
                        "encoding",
                        padding = { left = 1, right = 2 },
                        separator = separators,
                    },
                    {
                        "fileformat",
                        separator = separators,
                        symbols = {
                            unix = "LF",
                            dos = "CRLF",
                            mac = "CR",
                        }
                    },
                    {
                        "filetype",
                        padding = { left = 2, right = 1 },
                        separator = separators,
                    },
                },
                lualine_y = { "progress" },
                lualine_z = {{
                    "location",
                    padding = { left = 0, right = 1 },
                    separator = { left = separator_left },
                }},
            },
        })
    end,
}
