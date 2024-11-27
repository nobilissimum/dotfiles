local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end


local function map(src_table, func)
    local dist_table = {}
    for key, value in pairs(src_table) do
        dist_table[key] = func(value)
    end

    return dist_table
end


-- Font
local fonts = {
    { name = "SF Mono", half = "Bold", bold = "Bold", native = true },
    { name = "JetBrains Mono", half = "Medium", bold = "Bold" },
    { name = "JetBrainsMono Nerd Font", half = "Medium", bold = "Bold" },
}
local harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
local font_with_fallback = wezterm.font_with_fallback(map(
    fonts,
    function(item)
        return { family = item.name, harfbuzz_features = harfbuzz_features }
    end
))
local font_size = 10.25

config.font = font_with_fallback
config.font_rules = {
    -- Bold
    {
        intensity = "Bold",
        italic = false,
        font = wezterm.font_with_fallback(map(
            fonts,
            function(item)
                local font_name = item.name
                local font = { harfbuzz_features = harfbuzz_features }
                if item.native then
                    font.weight = item.bold
                else
                    font_name = item.name .. " " .. item.bold
                end
                font.family = font_name
                return font
            end
        )),
    },

    -- Half
    {
        intensity = "Half",
        italic = false,
        font = wezterm.font_with_fallback(map(
            fonts,
            function(item)
                local font_name = item.name
                local font = { harfbuzz_features = harfbuzz_features }
                if item.native then
                    font.weight = item.half
                else
                    font_name = item.name .. " " .. item.half
                end
                font.family = font_name
                return font
            end
        )),
    },
}
config.font_size = font_size


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
config.line_height = 1.15
config.window_padding = {
    left = 0,
    right = 0,
    top = 1,
    bottom = 0,
}


-- Scrolling
config.scrollback_lines = 9999
config.keys = {
    { key = "PageUp", mods = "SHIFT", action = wezterm.action.ScrollByPage(-2) },
    { key = "PageDown", mods = "SHIFT", action = wezterm.action.ScrollByPage(2) },
}


-- Window and tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_frame = {
    inactive_titlebar_bg = "#1D232E",
    inactive_titlebar_fg = "#1D232E",

    active_titlebar_bg = "#1F2A35",
    active_titlebar_fg = "#ffffff",

    font = font_with_fallback,
    font_size = font_size - 2,
}


-- Keybinds
config.keys = {
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
}


-- Rendering
config.enable_wayland = true
config.use_ime = true
config.front_end = "OpenGL"


-- Audio
config.audible_bell = "Disabled"

return config
