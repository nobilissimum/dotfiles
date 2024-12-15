local is_module_available = function(path)
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

local config = require("wezterm-nobilissimum")

local custom_path = "wezterm-custom"
if is_module_available(custom_path) then
    config = require(custom_path)(config)
end

return config
