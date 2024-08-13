local base_path = "craftznake."
local wezterm = require("wezterm")
local act = wezterm.action
local platform = require(base_path .. "utils.platform")()
local split_nav = require(base_path .. "utils.vim")

local mod = {}

if platform.is_mac then
	mod.SUPER = "CTRL"
elseif platform.is_win or platform.is_linux then
	mod.SUPER = "ALT" -- to not conflict with Windows key shortcuts
end

-- stylua: ignore
local keys = {
  -- panels
  {
    key = '\\',
    mods = 'LEADER',
    action = act.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  {
    key = '|',
    mods = 'LEADER',
    action = act.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
      top_level=true,
    },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = act.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    },
  },
  {
    key = '_',
    mods = 'LEADER',
    action = act.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
      top_level=true,
    },
  },
  -- Tmux copy mode
  {
    key = '[',
    mods = 'LEADER',
    action = wezterm.action.ActivateCopyMode,
  },
  -- Tmux zen mode
  {
    key = 'z',
    mods = 'LEADER',
    action = wezterm.action.TogglePaneZoomState,
  },
  -- tmux new tab
  {
    key = 'c',
    mods = 'LEADER',
    action = act.SpawnTab 'CurrentPaneDomain',
  },
  -- navigate between tabs
  {
    key = 'n',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'p',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(-1),
  },
  -- rename tab
 {
    key = ',',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(
        function(window, _, line)
          if line then
            window:active_tab():set_title(line)
          end
        end
      ),
    },
  },
  -- move tab
  { key = '<', mods = 'LEADER', action = act.MoveTabRelative(-1) },
  { key = '>', mods = 'LEADER', action = act.MoveTabRelative(1) },
  { key = '8', mods = 'CTRL', action = act.PaneSelect },
  { key = '0', mods = 'CTRL', action = act.PaneSelect { mode = 'SwapWithActive', },
  },
  -- show tab navigator
  {
    key = 'w',
    mods = 'LEADER',
    action = act.ShowTabNavigator,
  },
  {
    key = 'x',
    mods = 'LEADER',
    action = act.CloseCurrentPane{confirm=false},
  },
  -- some default keymap,
  {key="c", mods="SUPER", action = act.CopyTo 'Clipboard'},
  {key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard'},
  {
    key='P',
    mods= 'CTRL',
    action=act.ActivateCommandPalette,
  },
  { key = '-', mods = 'CMD', action = wezterm.action.DecreaseFontSize },
  { key = '+', mods = 'CMD', action = wezterm.action.IncreaseFontSize },
  { key = 'q', mods = 'CMD', action = wezterm.action.QuitApplication },

		-- move between split panes
		split_nav("move", "h"),
		split_nav("move", "j"),
		split_nav("move", "k"),
		split_nav("move", "l"),
		-- resize panes
		split_nav("resize", "h"),
		split_nav("resize", "j"),
		split_nav("resize", "k"),
		split_nav("resize", "l"),
}

return {
	disable_default_key_bindings = true,
	leader = { key = "Space", mods = mod.SUPER, timeout_milliseconds = 1000 },
	keys = keys,
}
