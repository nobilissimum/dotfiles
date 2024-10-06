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
config.color_scheme = "Catppuccin Macchiato"

-- Spacing
config.line_height = 1.4
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
