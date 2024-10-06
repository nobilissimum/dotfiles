local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Font
config.font = wezterm.font_with_fallback({
    { family = "Source Code Pro", harfbuzz_features = { "calt=0", "clig=0", "liga=0" }},
    { family = "SauceCodePro Nerd Font", harfbuzz_features = { "calt=0", "clig=0", "liga=0" }},
})
config.font_size = 10

-- Colors
-- config.color_scheme = "Catppuccin Macchiato"
config.colors = {
    foreground = "silver",
    background = "#1D232E",

    cursor_bg = "silver",
    cursor_fg = "black",

    cursor_border = "#52ad70",

    selection_fg = "black",
    selection_bg = "#fffacd",

    ansi = {
        "#000000",
        "#f77172",
        "#65a884",
        "#65a884",
        "#74add2",
        "#a980c4",
        "#2d949f",
        "#eeeeee",
    },

    brights = {
        "#000000",
        "#f77172",
        "#65a884",
        "#65a884",
        "#74add2",
        "#a980c4",
        "#2d949f",
        "#eeeeee",
    },
}

-- Spacing
config.line_height = 1.6
config.window_padding = {
    left = 0,
    right = 0,
    top = 1,
    bottom = 0,
}

-- Window and tabs
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"

return config
