function move(dir)
    local counter = {
        right = 0,
        left = 0
    }
    return function()
        counter[dir] = _move(dir, counter[dir])
    end
end

function _move(dir, ct)
    local screenWidth = hs.screen.mainScreen():frame().w
    local focusedWindowFrame = hs.window.focusedWindow():frame()
    local x = focusedWindowFrame.x
    local w = focusedWindowFrame.w
    local value = dir == 'right' and x + w or x
    local valueTarget = dir == 'right' and screenWidth or 0
    if value ~= valueTarget then
        hs.window.focusedWindow():moveToUnit(hs.layout[dir .. 50])
        return 50
    elseif ct == 50 then
        hs.window.focusedWindow():moveToUnit(hs.layout[dir .. 70])
        return 70
    elseif ct == 70 then
        hs.window.focusedWindow():moveToUnit(hs.layout[dir .. 30])
        return 30
    else
        hs.window.focusedWindow():moveToUnit(hs.layout[dir .. 50])
        return 50
    end
end

--- window
hs.window.animationDuration = 0
hs.hotkey.bind({"ctrl", "cmd"}, "Right", move('right'))
hs.hotkey.bind({"ctrl", "cmd"}, "Left", move('left'))

-- open from:
-- https://liuhao.im/english/2017/06/02/macos-automation-and-shortcuts-with-hammerspoon.html

function open(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == 'Finder' then
            hs.appfinder.appFromName(name):activate()
        end
        if name == 'emacs' then
            hs.appfinder.appFromName(name):activate()
        end
    end
end

function toggleWindowFocus(windowName)
    return function()
        window = hs.window.filter.new(windowName):getWindows()[1]
        if hs.window.focusedWindow() == window then
            window = windowHistory
        end
        windowHistory = hs.window.focusedWindow()
        -- hs.mouse.setAbsolutePosition(window:frame().center)
        window:focus()
    end
end

hs.hotkey.bind("cmd", 'H', function() end)
hs.hotkey.bind({"shift", "cmd"}, 'Q', function() end)
hs.hotkey.bind({"control", "cmd"}, 'Q', function() end)
hs.hotkey.bind({"cmd", "shift"}, 'e', open('emacs'))
hs.hotkey.bind({"cmd", "shift"}, 'n', function () hs.application.launchOrFocus("Terminal") end)
hs.hotkey.bind({"cmd", "shift", "control"}, 'n', function () hs.application.launchOrFocus("Safari") end)

hs.hotkey.bind({"cmd", "shift"}, 'e', toggleWindowFocus('emacs'))
hs.hotkey.bind({"cmd", "shift"}, 'n', toggleWindowFocus('Terminal'))
