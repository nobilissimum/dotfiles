local utils = require("utils")

hs.loadSpoon("EmmyLua")

local app_bindings = {
  ["1"] = "Ghostty",
}

local app_bindings_alt = {}

local browser_name = "Edge"
local browser_window_bindings = {
  ["1"] = "Primary",
  ["2"] = "Secondary",
}

local maximize_margin = 10

if utils.is_module_available("custom") then
  local custom = require("custom")

  for k, v in pairs(custom.app_bindings or {}) do
    app_bindings[k] = v
  end

  for k, v in pairs(custom.app_bindings_alt or {}) do
    app_bindings_alt[k] = v
  end

  browser_name = custom.browser_name or browser_name
  for k, v in pairs(custom.browser_window_bindings or {}) do
    browser_window_bindings[k] = v
  end

  maximize_margin = custom.maximize_margin or maximize_margin
end

for key, appName in pairs(app_bindings) do
  hs.hotkey.bind({ "alt" }, key, function()
    utils.focus_app(appName)
  end)
end

for key, appName in pairs(app_bindings_alt) do
  hs.hotkey.bind({ "alt", "shift" }, key, function()
    utils.focus_app(appName)
  end)
end

for key, windowName in pairs(browser_window_bindings) do
  hs.hotkey.bind({ "alt", "shift" }, key, function()
    utils.focus_window(browser_name, windowName)
  end)
end

hs.hotkey.bind({ "ctrl", "cmd" }, "R", function()
  hs.reload()
  utils.toast("Configuration reloaded")
end)
hs.hotkey.bind({ "ctrl", "cmd" }, "L", function()
  hs.openConsole()
end)

local function maximize_with_padding(win)
  if not win then
    return
  end
  local screen = win:screen():frame()

  win:setFrame({
    x = screen.x + maximize_margin,
    y = screen.y + maximize_margin,
    w = screen.w - 2 * maximize_margin,
    h = screen.h - 2 * maximize_margin,
  })
end

hs.hotkey.bind({ "option" }, "M", function()
  maximize_with_padding(hs.window.focusedWindow())
end)

hs.hotkey.bind({ "option", "ctrl" }, "M", function()
  for _, win in ipairs(hs.window.visibleWindows()) do
    if win:isStandard() then
      maximize_with_padding(win)
    end
  end
  utils.toast("Maximized all windows")
end)

utils.config_watcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", utils.reload_config):start()
utils.toast("Configuration reloaded")
