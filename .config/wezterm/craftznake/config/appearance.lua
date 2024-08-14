return {
	animation_fps = 60,
	max_fps = 60,
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",

	-- color scheme
	color_scheme = "One Dark (Gogh)",

	-- background
	window_background_opacity = 0.9,
	-- scrollbar
	enable_scroll_bar = true,

	-- tab bar
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = true,
	tab_max_width = 10,
	show_tab_index_in_tab_bar = false,
	switch_to_last_active_tab_when_closing_tab = true,
	colors = {
		tab_bar = {
			active_tab = {
				fg_color = "#6EACDA",
				bg_color = "#282C34",
			},
			inactive_tab = {
				fg_color = "#677D6A",
				bg_color = "#282C30",
			},
		},
	},

	-- window
	window_padding = {
		left = 5,
		right = 10,
		top = 10,
		bottom = 5,
	},
	window_close_confirmation = "NeverPrompt",
	window_frame = {
		active_titlebar_bg = "#090909",
		-- font = fonts.font,
		-- font_size = fonts.font_size,
	},
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.65,
	},
}
