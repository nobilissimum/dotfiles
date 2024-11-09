local config = require("wezterm-nobilissimum")
config.default_prog = { "C:\\Windows\\System32\\wsl.exe", "-d", "Ubuntu-24.04", "--cd", "~" }
return config
