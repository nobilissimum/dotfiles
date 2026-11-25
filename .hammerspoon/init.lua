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

-- Characters macOS types for option (+ shift) + number row keys. When the
-- hotkey is not caught (e.g. the focused app grabs the key first), the
-- character itself is caught instead.
local number_row_keys = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=" }
local option_chars = { "¡", "™", "£", "¢", "∞", "§", "¶", "•", "ª", "º", "–", "≠" }
local option_shift_chars = { "⁄", "€", "‹", "›", "ﬁ", "ﬂ", "‡", "°", "·", "‚", "—", "±" }

local key_chars = { alt = {}, alt_shift = {} }
for i, key in ipairs(number_row_keys) do
  key_chars.alt[key] = option_chars[i]
  key_chars.alt_shift[key] = option_shift_chars[i]
end

local char_handlers = {}
local last_fired = {}

-- Bind both the hotkey and the character it produces, firing at most once per press.
local function bind_with_char(shift, key, fn)
  local id = (shift and "alt_shift:" or "alt:") .. key
  local function handler()
    local now = hs.timer.secondsSinceEpoch()
    if last_fired[id] and now - last_fired[id] < 0.1 then
      return
    end
    last_fired[id] = now
    fn()
  end

  hs.hotkey.bind(shift and { "alt", "shift" } or { "alt" }, key, handler)

  local char = key_chars[shift and "alt_shift" or "alt"][key]
  if char then
    char_handlers[char] = handler
  end
end

for key, appName in pairs(app_bindings) do
  bind_with_char(false, key, function()
    utils.focus_app(appName)
  end)
end

for key, appName in pairs(app_bindings_alt) do
  bind_with_char(true, key, function()
    utils.focus_app(appName)
  end)
end

for key, windowName in pairs(browser_window_bindings) do
  bind_with_char(true, key, function()
    utils.focus_window(browser_name, windowName)
  end)
end

utils.char_tap = hs.eventtap
  .new({ hs.eventtap.event.types.keyDown }, function(event)
    local flags = event:getFlags()
    if flags.cmd or flags.ctrl then
      return false
    end
    local handler = char_handlers[event:getCharacters()]
    if handler then
      handler()
      return true
    end
    return false
  end)
  :start()

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
