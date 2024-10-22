local base_path = "craftznake."
local wezterm = require("wezterm")
local act = wezterm.action
-- local split_nav = require(base_path .. "utils.vim")
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
	keyset(mods.L, "c", act.SpawnTab("CurrentPaneDomain")),
	-- navigate between tabs
	keyset(mods.L, "n", act.ActivateTabRelative(1)),
	keyset(mods.L, "p", act.ActivateTabRelative(-1)),
	-- tmux rename tab
	keyset(mods.L, ",", rename_tab_helper()),
	-- move tab
	keyset(mods.L, "<", act.MoveTabRelative(-1)),
	keyset(mods.L, ">", act.MoveTabRelative(1)),
	keyset(mods.L, ";", act.PaneSelect),
	keyset(mods.L, "m", act.PaneSelect({ mode = "SwapWithActiveKeepFocus" })),
	-- show tab navigator
	keyset(mods.L, "w", act.ShowTabNavigator),
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
	-- keyset(mods.Cw, "h", vim_utils.resize(mods.C, "h")),
	-- keyset(mods.Cw, "j", vim_utils.resize(mods.C, "j")),
	-- keyset(mods.Cw, "k", vim_utils.resize(mods.C, "k")),
	-- keyset(mods.Cw, "l", vim_utils.resize(mods.C, "l")),
}

return {
	disable_default_key_bindings = false,
	leader = { key = "Space", mods = mods.C, timeout_milliseconds = 1000 },
	keys = mytable.flatten_list(keys),
}
