local wezterm = require("wezterm")

-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function navigate_vim(mods, key)
	return wezterm.action_callback(function(win, pane)
		if is_vim(pane) then
			win:perform_action({
				SendKey = { key = key, mods = mods },
			}, pane)
		else
			-- action()
			win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
		end
	end)
end

local function resize_vim(mods, key)
	return wezterm.action_callback(function(win, pane)
		if is_vim(pane) then
			win:perform_action({
				SendKey = { key = key, mods = mods },
			}, pane)
		else
			win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
		end
	end)
end
-- return Split_nav
return {
	navigate = navigate_vim,
	resize = resize_vim,
}
