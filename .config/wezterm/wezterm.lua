local wezterm_nobilissimum = require("wezterm-nobilissimum")
local config = wezterm_nobilissimum.config
local is_module_available = wezterm_nobilissimum.is_module_available

local custom_path = "wezterm-custom"
if is_module_available(custom_path) then
    config = require(custom_path).config(config)
end

return config
