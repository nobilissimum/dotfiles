local function focus_app(app_name)
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

local function focus_window(app_name, window_title)
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

local function focus_edge_window(window_name)
    focus_window("Edge", window_name)
end

local app_bindings = {
    ["1"] = "Ghostty",
    ["2"] = "Teams",
    ["3"] = "Apidog",
    ["4"] = "Trello",
    ["5"] = "Obsidian",
}

local edge_window_bindings = {
    ["1"] = "Primary",
    ["2"] = "Secondary",
    ["3"] = "Incognito",
}

for key, appName in pairs(app_bindings) do
    hs.hotkey.bind({"alt"}, key, function()
        focus_app(appName)
    end)
end

for key, windowName in pairs(edge_window_bindings) do
    hs.hotkey.bind({"alt", "shift"}, key, function()
        focus_edge_window(windowName)
    end)
end

local function reload_config(files)
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

hs.hotkey.bind({"ctrl", "cmd"}, "R", function()
    reload_config({os.getenv("HOME") .. "/.hammerspoon/"})
    hs.notify.new({title="Hammerspoon", informativeText="Configuration reloaded"}):send()
end)
hs.hotkey.bind({"ctrl", "cmd"}, "L", function()
    hs.openConsole()
end)

hs.hotkey.bind({"option"}, "M", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  local margin = 10
  win:setFrame({
    x = screen.x + margin,
    y = screen.y + margin,
    w = screen.w - 2 * margin,
    h = screen.h - 2 * margin
  })
end)

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()
hs.notify.new({title="Hammerspoon", informativeText="Configuration reloaded"}):send()
