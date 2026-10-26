local M = {}

function M.focus_app(app_name)
    local app = hs.application.find(app_name)
    if app then
        -- If app is found, bring it to focus
        app:activate()
    else
        -- If app is not running, try to launch it
        hs.application.launchOrFocus(app_name)
        hs.notify.new({title="Hammerspoon", informativeText="Launching: " .. app_name}):send()
    end
end

function M.focus_window(app_name, window_title)
    local app = hs.application.find(app_name)
    if app then
        local windows = app:allWindows()
        for _, window in ipairs(windows) do
            local title = window:title()
            -- Check if the window title contains the specified name
            if title and string.find(title:lower(), window_title:lower()) then
                window:focus()
                return
            end
        end
        -- If no matching window found, just focus the app
        app:activate()
        hs.notify.new({title="Hammerspoon", informativeText="No window " .. window_title .. " for " .. app_name}):send()
    else
        -- If app is not running, launch it
        hs.application.launchOrFocus(app_name)
        hs.notify.new({title="Hammerspoon", informativeText="Launching: " .. app_name}):send()
    end
end

function M.is_module_available(path)
    if package.loaded[path] then
        return true
    end

    local searchers = package.searchers or package.loaders
    for _, searcher in ipairs(searchers) do
        local loader = searcher(path)
        if type(loader) == "function" then
            package.preload[path] = loader
            return true
        end
    end

    return false
end

function M.reload_config(files)
    local do_reload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            do_reload = true
        end
    end

    if do_reload then
        hs.reload()
    end
end

return M
