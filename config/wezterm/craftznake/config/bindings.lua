local base_path = "craftznake."
local wezterm = require("wezterm")
local act = wezterm.action

local vim_utils = require(base_path .. "utils.vim")
local mods = require(base_path .. "utils.keys").mods
local keyset = require(base_path .. "utils.keys").keyset
local mytable = require(base_path .. "utils.stdlib").mytable

local function rename_tab_helper()
	return act.PromptInputLine({
		description = "Enter new name for tab",
		action = wezterm.action_callback(function(window, _, line)
			if line then
				window:active_tab():set_title(line)
			end
		end),
	})
end

-- https://github.com/wez/wezterm/issues/909
-- newtab_to_next create new tab
-- and move that tab to the next tab of the current active tab
--
-- This one is default behavior from Tmux
local newtab_to_next = wezterm.action_callback(function(win, pane)
	-- Returns the MuxWindow representation of this window.
	local mux_win = win:mux_window()
	for _, item in ipairs(mux_win:tabs_with_info()) do
		print(item.is_active)
		if item.is_active then
			mux_win:spawn_tab({})
			win:perform_action(act.MoveTab(item.index + 1), pane)
			return
		end
	end
end)

local function rename_workspace_helper()
	return act.PromptInputLine({
		description = "Enter new name for workspace",
		action = wezterm.action_callback(function(_, _, line)
			if line then
				wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
			end
		end),
	})
end

local keys = {
	keyset(mods.CS, "f", act.Search({ CaseInSensitiveString = "" })),
	keyset(mods.L, "\\", act.SplitPane({ direction = "Right", size = { Percent = 50 } })),
	keyset(mods.L, "|", act.SplitPane({ direction = "Right", size = { Percent = 50 }, top_level = true })),
	keyset(mods.L, "-", act.SplitPane({ direction = "Down", size = { Percent = 50 } })),
	keyset(mods.L, "_", act.SplitPane({ direction = "Down", size = { Percent = 50 }, top_level = true })),
	-- Tmux copy mode
	keyset(mods.L, "[", act.ActivateCopyMode),
	-- Tmux zen mode
	keyset(mods.L, "z", act.TogglePaneZoomState),
	-- tmux new tab
	keyset(mods.L, "c", newtab_to_next),
	-- navigate between tabs
	keyset(mods.L, "n", act.ActivateTabRelative(1)),
	keyset(mods.L, "p", act.ActivateTabRelative(-1)),
	keyset(mods.L, "o", act.ActivateLastTab),
	-- move tab
	keyset(mods.L, "<", act.MoveTabRelative(-1)),
	keyset(mods.L, ">", act.MoveTabRelative(1)),
	keyset(mods.L, ";", act.PaneSelect),
	keyset(mods.L, "m", act.PaneSelect({ mode = "SwapWithActiveKeepFocus" })),
	-- close current pane or tab
	keyset(mods.L, "x", act.CloseCurrentPane({ confirm = false })),
	-- some default keymap
	keyset(mods.D, "c", act.CopyTo("Clipboard")),
	keyset(mods.D, "v", act.PasteFrom("Clipboard")),
	keyset(mods.CS, "p", act.ActivateCommandPalette),
	keyset(mods.D, "-", act.DecreaseFontSize),
	keyset(mods.D, "+", act.IncreaseFontSize),
	keyset(mods.D, "q", act.QuitApplication),
	keyset(mods.D, "h", act.Hide),
	keyset(mods.CS, "y", act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" })),
	-- move between split panes
	keyset(mods.C, "h", vim_utils.navigate(mods.C, "h")),
	keyset(mods.C, "j", vim_utils.navigate(mods.C, "j")),
	keyset(mods.C, "k", vim_utils.navigate(mods.C, "k")),
	keyset(mods.C, "l", vim_utils.navigate(mods.C, "l")),
	-- -- resize panes
	keyset(mods.CS, "h", vim_utils.resize(mods.CS, "h")),
	keyset(mods.CS, "j", vim_utils.resize(mods.CS, "j")),
	keyset(mods.CS, "k", vim_utils.resize(mods.CS, "k")),
	keyset(mods.CS, "l", vim_utils.resize(mods.CS, "l")),
	keyset(mods.C, "E", act.EmitEvent("trigger-vim-with-scrollback")),
	-- show tab navigator
	keyset(mods.L, "w", act.ShowLauncherArgs({ flags = "FUZZY|TABS" })),
	-- tmux rename tab
	keyset(mods.L, ",", rename_tab_helper()),

	-- show work[s]paces navigator
	keyset(mods.L, "s", act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" })),
	keyset(mods.L, ".", rename_workspace_helper()),
}

return {
	disable_default_key_bindings = false,
	leader = { key = "Space", mods = mods.CSAD, timeout_milliseconds = 1000 },
	keys = mytable.flatten_list(keys),
}
