local wezterm = require("wezterm")

local function is_module_available(path)
    if package.loaded[path] then
        return true
    else
        for _, searcher in ipairs(package.searchers) do
            local loader = searcher(path)
            if type(loader) == "function" then
                package.preload[path] = loader
                return true
            end
        end

        return false
    end
end

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
local font_specs = {
    { name = "Geist Mono", regular = "Regular", half = "Bold", bold = "Bold" },
    { name = "GeistMono Nerd Font", regular = "Regular", half = "Regular", bold = "Regular", static = true },
}

local custom_path = "wezterm-custom"
if is_module_available(custom_path) then
    local custom_font_specs = require(custom_path).font_specs
    if (custom_font_specs ~= nil) and (#custom_font_specs > 0) then
        font_specs = custom_font_specs
    end
end

local harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
local font_size = 10.5

local function get_weighted_font(weighted_fonts, weight, harfbuzz)
    return wezterm.font_with_fallback(map(
        weighted_fonts,
        function(item)
            local font_name = item.name
            local font = { harfbuzz_features = harfbuzz }
            if item.native then
                font.weight = item[weight]
            elseif item.static then
            elseif item[weight] then
                font_name = item.name .. " " .. item[weight]
            end
            font.family = font_name
            return font
        end
    ))
end

local font_regular = get_weighted_font(font_specs, "regular", harfbuzz_features)
local font_half = get_weighted_font(font_specs, "half", harfbuzz_features)
local font_bold = get_weighted_font(font_specs, "bold", harfbuzz_features)

config.font = font_regular
config.font_rules = {
    -- Bold
    {
        intensity = "Bold",
        italic = false,
        font = font_bold,
    },

    -- Half
    {
        intensity = "Half",
        italic = false,
        font = font_half,
    },
}
config.font_size = font_size


-- Colors
config.colors = {
    foreground = "#dde2f3",
    background = "#1d232e",

    cursor_bg = "#dde2f3",
    cursor_fg = "#0f172a",

    cursor_border = "#52ad70",

    selection_fg = "none",
    selection_bg = "#393c4d",

    ansi = {
        "#0f172a",
        "#f77172",
        "#65a884",
        "#cec999",
        "#74add2",
        "#a980c4",
        "#2d949f",
        "#dde2f3",
    },

    brights = {
        "#535b68",
        "#f77172",
        "#65a884",
        "#cec999",
        "#74add2",
        "#a980c4",
        "#2d949f",
        "#dde2f3",
    },
}


-- Cursor
config.default_cursor_style = "SteadyUnderline"
config.force_reverse_video_cursor = false


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


-- Window and tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_frame = {
    inactive_titlebar_bg = "#1D232E",
    inactive_titlebar_fg = "#1D232E",

    active_titlebar_bg = "#1F2A35",
    active_titlebar_fg = "#ffffff",

    font = font_regular,
    font_size = font_size - 2,
}


-- Keybinds
config.disable_default_key_bindings = true
config.keys = {
    { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
    { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

    { key = "PageUp", mods = "SHIFT", action = wezterm.action.ScrollByPage(-2) },
    { key = "PageDown", mods = "SHIFT", action = wezterm.action.ScrollByPage(2) },

    { key = ")", mods = "CTRL", action = wezterm.action.ResetFontSize },
    { key = ")", mods = "SHIFT|CTRL", action = wezterm.action.ResetFontSize },
    { key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },
    { key = "0", mods = "SHIFT|CTRL", action = wezterm.action.ResetFontSize },
    { key = "0", mods = "SUPER", action = wezterm.action.ResetFontSize },

    { key = "_", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
    { key = "_", mods = "SHIFT|CTRL", action = wezterm.action.DecreaseFontSize },
    { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
    { key = "-", mods = "SHIFT|CTRL", action = wezterm.action.DecreaseFontSize },
    { key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },

    { key = "+", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
    { key = "+", mods = "SHIFT|CTRL", action = wezterm.action.IncreaseFontSize },
    { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
    { key = "=", mods = "SHIFT|CTRL", action = wezterm.action.IncreaseFontSize },
    { key = "=", mods = "SUPER", action = wezterm.action.IncreaseFontSize },

    { key = "L", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
    { key = "L", mods = "SHIFT|CTRL", action = wezterm.action.ShowDebugOverlay },
    { key = "l", mods = "SHIFT|CTRL", action = wezterm.action.ShowDebugOverlay },

    { key = "w", mods = "SUPER", action = wezterm.action.CloseCurrentPane { confirm = false } },
    { key = "n", mods = "SUPER", action = wezterm.action.ToggleFullScreen },
}


-- Rendering
config.enable_wayland = true
config.use_ime = true
config.max_fps = 120
config.front_end = "WebGpu"
config.bold_brightens_ansi_colors = false
config.webgpu_power_preference = "HighPerformance"
config.freetype_load_target = "Normal"

local webgpu_preferred_adapter = {}
local gpu_deprio = {}
for _, gpu in pairs(wezterm.gui.enumerate_gpus()) do
    if gpu.backend == "Dx12" and gpu.device_type == "DiscreteGpu" then
        webgpu_preferred_adapter = gpu
        break
    end

    if gpu.device_type == "DiscreteGpu" and ((next(gpu_deprio) ~= nil and gpu_deprio.backend ~= "Vulkan") or (next(gpu_deprio) == nil)) then
        gpu_deprio = gpu
    end
end

if next(webgpu_preferred_adapter) == nil and next(gpu_deprio) ~= nil then
    webgpu_preferred_adapter = gpu_deprio
end

if next(webgpu_preferred_adapter) == nil then
    config.front_end = "OpenGL"
else
    config.webgpu_preferred_adapter = webgpu_preferred_adapter
end


-- Audio
config.audible_bell = "Disabled"

return {
    config = config,
    is_module_available = is_module_available,
}
