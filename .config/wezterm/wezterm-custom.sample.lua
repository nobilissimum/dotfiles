local custom_config = function(config)
    config.default_prog = { "C:\\Windows\\System32\\wsl.exe", "-d", "openSUSE-Tumbleweed", "--cd", "~" }
    return config
end

return custom_config

