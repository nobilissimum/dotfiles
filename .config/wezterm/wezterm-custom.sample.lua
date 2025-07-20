local custom_config = function(config)
    -- For WSL
    config.default_prog = { "C:\\Windows\\System32\\wsl.exe", "-d", "openSUSE-Tumbleweed", "--cd", "~" }

    -- For MacOS
    config.window_background_opacity = 0.9
    config.macos_window_background_blur = 30
    config.font_size = 14

    return config
end

local font_specs = {
    { name = "Geist Mono", regular = "Regular", half = "Bold", bold = "Bold", native = true },
    { name = "GeistMono Nerd Font", regular = "Regular", half = "Regular", bold = "Regular", native = true },
}

return  {
    config = custom_config,
    font_specs = font_specs,
}
