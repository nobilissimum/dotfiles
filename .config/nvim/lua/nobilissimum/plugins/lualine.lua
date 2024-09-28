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

            bright_black = "#203A4A",

            hush_main = "#1D232E",
        }

        local hush_theme = {
            normal = {
                a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bright_black },
                c = { fg = colors.fg, bg = colors.hush_main },
                x = { fg = colors.fg, bg = colors.bright_black },
                y = { fg = colors.fg, bg = colors.hush_main },
            },
            command = {
                a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bright_black },
                x = { fg = colors.fg, bg = colors.bright_black },
                y = { fg = colors.fg, bg = colors.hush_main },
            },
            insert = {
                a = { fg = colors.bg, bg = colors.green, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bright_black },
                x = { fg = colors.fg, bg = colors.bright_black },
                y = { fg = colors.fg, bg = colors.hush_main },
            },
            visual = {
                a = { fg = colors.bg, bg = colors.magenta, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bright_black },
                x = { fg = colors.fg, bg = colors.bright_black },
                y = { fg = colors.fg, bg = colors.hush_main },
            },
            replace = {
                a = { fg = colors.bg, bg = colors.red, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bright_black },
                x = { fg = colors.fg, bg = colors.bright_black },
                y = { fg = colors.fg, bg = colors.hush_main },
            },
            inactive = {
                a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bg },
                c = { fg = colors.fg, bg = colors.bg },
                x = { fg = colors.fg, bg = colors.bg },
                y = { fg = colors.fg, bg = colors.bg },
            },
        }

        local separators = { left = "", right = "" }

        require("lualine").setup({
            options = {
                theme = hush_theme,
                component_separators = { left = '•', right = '•'},
                section_separators = { left = "", right = "" },
                globalstatus = true,
            },
            sections = {
                lualine_a = {{ "mode", separator = separators } },
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
                    separator = separators,
                }},
            },
        })
    end,
}
