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
            },
            command = {
                a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bright_black },
            },
            insert = {
                a = { fg = colors.bg, bg = colors.green, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bright_black },
            },
            visual = {
                a = { fg = colors.bg, bg = colors.magenta, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bright_black },
            },
            replace = {
                a = { fg = colors.bg, bg = colors.red, gui = "bold" },
                b = { fg = colors.fg, bg = colors.git },
            },
            inactive = {
                a = { fg = colors.fg, bg = colors.bg, gui = "bold" },
                b = { fg = colors.fg, bg = colors.bg },
                c = { fg = colors.fg, bg = colors.bg },
            },
        }

        require("lualine").setup({
            options = {
                theme = hush_theme,
                component_separators = { left = '•', right = '•'},
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = {{ "mode", separator = { left = "", right = "" } }},
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = {{ "location", separator = { left = "", right = "" } }},
            },
        })
    end,
}
