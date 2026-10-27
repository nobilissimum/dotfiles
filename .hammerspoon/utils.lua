local M = {}

M.toast_style = {
    font = ".AppleSystemUIFont",
    text_size = 14,
    text_color = { white = 0.95, alpha = 1 },
    fill_color = { red = 0.110, green = 0.122, blue = 0.153, alpha = 0.9 },
    stroke_color = { white = 0.9, alpha = 0.15 },
    stroke_width = 1,
    radius = 24,
    padding_x = 24,
    padding_y = 16,
    bottom_margin = 150,
    duration = 10,
    fade = 0.2,
    shadow_color = { white = 0, alpha = 0.45 },
    shadow_blur = 16,
    shadow_offset_y = 4,
}

local current_toast

function M.toast(text, opts)
    local style = {}
    for k, v in pairs(M.toast_style) do style[k] = v end
    for k, v in pairs(opts or {}) do style[k] = v end

    if current_toast then
        current_toast:delete()
        current_toast = nil
    end

    local size = hs.drawing.getTextDrawingSize(text, { font = style.font, size = style.text_size })
    local width = math.ceil(size.w) + 2 * style.padding_x
    local height = math.ceil(size.h) + 2 * style.padding_y
    local screen = hs.screen.mainScreen():frame()

    local inset = style.shadow_blur > 0 and (style.shadow_blur + style.shadow_offset_y) or 0
    local canvas = hs.canvas.new({
        x = screen.x + (screen.w - width) / 2 - inset,
        y = screen.y + screen.h - height - style.bottom_margin - inset,
        w = width + 2 * inset,
        h = height + 2 * inset,
    })
    canvas:level(hs.canvas.windowLevels.overlay)
    canvas:behavior({ "canJoinAllSpaces", "stationary" })
    canvas[1] = {
        type = "rectangle",
        action = "strokeAndFill",
        frame = { x = inset, y = inset, w = width, h = height },
        withShadow = style.shadow_blur > 0,
        shadow = {
            blurRadius = style.shadow_blur,
            color = style.shadow_color,
            offset = { h = -style.shadow_offset_y, w = 0 },
        },
        roundedRectRadii = { xRadius = style.radius, yRadius = style.radius },
        fillColor = style.fill_color,
        strokeColor = style.stroke_color,
        strokeWidth = style.stroke_width,
    }
    canvas[2] = {
        type = "text",
        frame = { x = inset, y = inset + style.padding_y, w = width, h = height - style.padding_y },
        text = hs.styledtext.new(text, {
            font = { name = style.font, size = style.text_size },
            color = style.text_color,
            paragraphStyle = { alignment = "center" },
        }),
    }
    canvas:show()
    current_toast = canvas

    hs.timer.doAfter(style.duration, function()
        if current_toast == canvas then
            current_toast = nil
            canvas:delete(style.fade)
        end
    end)
end

function M.focus_app(app_name)
    local app = hs.application.find(app_name)
    if app then
        -- If app is found, bring it to focus
        app:activate()
    else
        -- If app is not running, try to launch it
        hs.application.launchOrFocus(app_name)
        M.toast("Launching: " .. app_name)
    end
end

function M.focus_window(app_name, window_title)
    local app = hs.application.find(app_name)
    if app then
        local windows = app:allWindows()
        for _, window in ipairs(windows) do
            local title = window:title()
            local is_find_bar = title and title:lower():find("^find on page for%s")
            if title and not is_find_bar and string.find(title:lower(), window_title:lower(), 1, true) then
                window:focus()
                return
            end
        end
        -- If no matching window found, just focus the app
        app:activate()
        M.toast("No window " .. window_title .. " for " .. app_name)
    else
        -- If app is not running, launch it
        hs.application.launchOrFocus(app_name)
        M.toast("Launching: " .. app_name)
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
