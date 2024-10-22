local wezterm = require("wezterm")

-- -- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This function returns the suggested title for a tab
-- It prefers the title that was set via tab:set_title() or wezterm cli set-tab-title,
-- but falls back to the title of the active pane in that tab
local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end
	return tab_info.tab_index .. ": " .. tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = "#090909"
	local background = "#090909"
	local foreground = "#808080"

	if tab.is_active then
		background = "#2b2042"
		foreground = "#c0c0c0"
	elseif hover then
		background = "#3b3052"
		foreground = "#909090"
	end

	local edge_foreground = background
	local title = tab_title(tab)

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	title = wezterm.truncate_left(title, max_width - 2)

	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

return {
	animation_fps = 60,
	max_fps = 60,
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",

	-- color scheme
	-- color_scheme = "Operator Mono Dark",
	color_scheme = "Rosé Pine Moon (base16)",
	-- color_scheme = "Rosé Pine Moon (Gogh)",
	-- background
	window_background_opacity = 0.8,
	macos_window_background_blur = 20,
	window_decorations = "INTEGRATED_BUTTONS|RESIZE",
	-- scrollbar
	enable_scroll_bar = true,
	adjust_window_size_when_changing_font_size = false,
	-- tab bar
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,

	-- window
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},
	colors = {
		tab_bar = {
			background = "#0b0022",
		},
	},
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.4,
	},
}
