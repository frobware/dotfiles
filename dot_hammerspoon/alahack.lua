--[[
 This piece of hammer spoon code tries to address the issue of not being able to
 switch between Alacritty instances in OSX.
 Details: https://github.com/alacritty/alacritty/issues/607

 To install:

  1. Install hammer spoon (https://www.hammerspoon.org/)
  2. Drop this file in your hammerspoon config directory:
    $HOME/.hammerspoon/others/alahack.lua
  3. Open your init.lua ($HOME/.hammerspoon/init.lua) and add this at the end:
    -- Load Alacritty hack
    ala_hack = require "others/alahack"
    -- Change the binding to your liking
    hs.hotkey.bind({"cmd", "ctrl"}, "I", ala_hack)
--]]

local function getWindows()
	local wins = hs.window.orderedWindows()
	local ala_windows = {}
	for i = 1, #wins do
		local w = wins[i]
		local a = w:application()
		if a:name() == "Alacritty" then
			table.insert(ala_windows, w)
		end
	end
	return ala_windows
end

local function getFocusWinName()
	return hs.window.focusedWindow():application():name()
end

--[[
Is the focus window alacritty?
  YES:
  - Do we have more instances?
    YES: focus on the next one
    NO: do nothing
  NO:
  - Do we have any alacritty instance?
    YES: go to any of the windows
    NO: open a new alacritty
--]]
local function run()
	local ala_windows = getWindows()
	local we_are_focused_in_alacritty = getFocusWinName() == 'Alacritty'
	if we_are_focused_in_alacritty then
		local focused_id = hs.window.focusedWindow():id()
		for i = 1, #ala_windows do
			if ala_windows[i]:id() ~= focused_id then
				hs:focus()
				ala_windows[i]:focus()
				break
			end
		end
	else -- We are not focus in alacrity
		if #ala_windows > 0 then -- No other alacritty windows
			ala_windows[1]:focus()
		else
			hs.application.launchOrFocus("Alacritty")
		end
	end
end

return run
