local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end


-- Font
local base_font = "Source Code Pro"
local nerd_font = "SauceCodePro Nerd Font"

local harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font = wezterm.font_with_fallback({
    { family = base_font, harfbuzz_features = harfbuzz_features },
    { family = nerd_font, harfbuzz_features = harfbuzz_features },
})
config.font_rules = {
    -- Bold
    {
        intensity = "Bold",
        italic = false,
        font = wezterm.font_with_fallback({
            { family = base_font .. " ExtraBold", harfbuzz_features = harfbuzz_features },
            { family = nerd_font, harfbuzz_faetures = harfbuzz_features },
        }),
    },

    -- Half
    {
        intensity = "Half",
        italic = false,
        font = wezterm.font_with_fallback({
            { family = base_font .. " Bold", harfbuzz_features = harfbuzz_features },
            { family = nerd_font, harfbuzz_faetures = harfbuzz_features },

        }),
    },
}
config.font_size = 10


-- Colors
config.colors = {
    foreground = "silver",
    background = "#1d232e",

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
        "#ffffff",
    },

    brights = {
        "#535b68",
        "#f77172",
        "#65a884",
        "#65a884",
        "#74add2",
        "#a980c4",
        "#2d949f",
        "#ffffff",
    },
}


-- Spacing
config.line_height = 1.25
config.window_padding = {
    left = 0,
    right = 0,
    top = 1,
    bottom = 0,
}


-- Scrolling
config.scrollback_lines = 9999
config.keys = {
    { key = "PageUp", mods = "SHIFT", action = wezterm.action.ScrollByPage(-1) },
    { key = "PageDown", mods = "SHIFT", action = wezterm.action.ScrollByPage(1) },
}


-- Window and tabs
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"


-- Keybinds
config.keys = {
    { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
}

return config
