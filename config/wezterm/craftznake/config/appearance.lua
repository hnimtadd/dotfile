local wezterm = require("wezterm")
local base_path = "craftznake."
local colorsutils = require(base_path .. "utils.colors")

local process_icons = {
	["bash"] = wezterm.nerdfonts.cod_terminal_bash,
	["btm"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["cargo"] = wezterm.nerdfonts.dev_rust,
	["curl"] = wezterm.nerdfonts.mdi_flattr,
	["docker"] = wezterm.nerdfonts.linux_docker,
	["docker-compose"] = wezterm.nerdfonts.linux_docker,
	["gh"] = wezterm.nerdfonts.dev_github_badge,
	["git"] = wezterm.nerdfonts.fa_git,
	["go"] = wezterm.nerdfonts.seti_go,
	["htop"] = wezterm.nerdfonts.mdi_chart_donut_variant,
	["kubectl"] = wezterm.nerdfonts.linux_docker,
	["kuberlr"] = wezterm.nerdfonts.linux_docker,
	["lazydocker"] = wezterm.nerdfonts.linux_docker,
	["lazygit"] = wezterm.nerdfonts.oct_git_compare,
	["lua"] = wezterm.nerdfonts.seti_lua,
	["make"] = wezterm.nerdfonts.seti_makefile,
	["node"] = wezterm.nerdfonts.mdi_hexagon,
	["nvim"] = wezterm.nerdfonts.custom_vim,
	["psql"] = "󱤢",
	["ruby"] = wezterm.nerdfonts.cod_ruby,
	["stern"] = wezterm.nerdfonts.linux_docker,
	["sudo"] = wezterm.nerdfonts.fa_hashtag,
	["usql"] = "󱤢",
	["vim"] = wezterm.nerdfonts.dev_vim,
	["wget"] = wezterm.nerdfonts.mdi_arrow_down_box,
	["zsh"] = wezterm.nerdfonts.dev_terminal,
}

local tabbar_bg = "#254336"
local colors = { "#395144", "#4E6C50", "#66785F", "#91AC8F" }

local text_fg = "#c0c0c0" -- Foreground color for the text across the fade

-- Return the Tab's current working directory
local function get_cwd(tab)
	return tab.active_pane.current_working_dir.file_path or ""
end

-- Remove all path components and return only the last value
local function remove_abs_path(path)
	return string.gsub(path, "(.*[/\\])(.*)", "%2")
end

--  return current directory name
-- if path is in home, return ~/relative path
-- if path is not in home, return absolute path
local function get_current_directory_pretty(path)
	local home = os.getenv("HOME")
	return string.gsub(path, "^" .. home, "~")
end

local function get_process_name(tab)
	if not tab.active_pane or tab.active_pane.foreground_process_name == "" then
		return "?"
	end

	local process_name = remove_abs_path(tab.active_pane.foreground_process_name)
	if process_name:find("kubectl") then
		process_name = "kubectl"
	end
	return process_name
end

-- Return the concise name or icon of the running process for display
local function get_process_icon(process_name)
	local icon = process_icons[process_name] or string.format("[%s]", process_name)
	return icon
end

-- Pretty format the tab title
local function format_title(tab)
	local process = get_process_name(tab)
	local icon = get_process_icon(process)
	local title
	if tab.is_active then
		title = tab.active_pane.title
	else
		title = process
	end

	local cwd = tab.active_pane.current_working_dir.file_path or "Unknown"
	cwd = remove_abs_path(cwd)

	return string.format("%s %s |  %s", icon, title, cwd)
end

-- Determine if a tab has unseen output since last visited
local function has_unseen_output(tab)
	if not tab.is_active then
		for _, pane in ipairs(tab.panes) do
			if pane.has_unseen_output then
				return true
			end
		end
	end
	return false
end

-- Returns manually set title (from `tab:set_title()` or `wezterm cli set-tab-title`) or creates a new one
local function get_tab_title(tab)
	local title = tab.tab_title
	if title and #title > 0 then
		return " " .. title .. " "
	end
	return " " .. format_title(tab) .. " "
end

-- On format tab title events, override the default handling to return a custom title
-- Docs: https://wezfurlong.org/wezterm/config/lua/window-events/format-tab-title.html
---@diagnostic disable-next-line: unused-local
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = get_tab_title(tab)
	local color = colorsutils.string_to_hex(get_cwd(tab))

	if tab.is_active then
		return {
			{ Attribute = { Intensity = "Bold" } },
			{ Background = { Color = color } },
			{ Foreground = { Color = colorsutils.get_contrast_color(color) } },
			{ Text = title },
		}
	end
	if has_unseen_output(tab) then
		return {
			{ Foreground = { Color = "#EBD168" } },
			{ Text = title },
		}
	end
	return title
end)

-- update right status bar
-- Docs: https://wezfurlong.org/wezterm/config/lua/window-events/update-right-status.html
-- @diagnostic display-next-line: unused-local
wezterm.on("update-status", function(window, pane)
	-- Each element holds the text for a cell in a "powerline" style << fade
	local cells = {}

	-- table.insert(cells, stats_library.current_stats_generator())

	-- Figure out the cwd and host of the current pane.
	-- This will pick up the hostname for the remote host if your
	-- shell is using OSC 7 on the remote host.
	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		local cwd = get_current_directory_pretty(cwd_uri.file_path)
		table.insert(cells, cwd)
	end

	-- I like my date/time in this style: "Wed Mar 3 08:14"
	local date = wezterm.strftime("%a %b %-d %H:%M")
	table.insert(cells, date)

	-- An entry for each battery (typically 0 or 1 battery)
	for _, b in ipairs(wezterm.battery_info()) do
		table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
	end

	-- The filled in variant of the < symbol
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

	-- Color palette for the backgrounds of each cell
	local elements = {} -- The elements to be formatted
	local num_cells = 0 -- How many cells have been formatted

	-- Translate a cell into elements
	local function push(text, is_last)
		local cell_no = num_cells + 1
		if cell_no == 1 then
			-- first cell must have bg of tabbar
			table.insert(elements, { Background = { Color = tabbar_bg } })
		else
			table.insert(elements, { Background = { Color = colors[cell_no - 1] } })
		end

		table.insert(elements, { Foreground = { Color = colors[cell_no] } })
		table.insert(elements, { Text = SOLID_LEFT_ARROW })
		table.insert(elements, "ResetAttributes") -- Reset attributes affect to next element
		table.insert(elements, { Foreground = { Color = text_fg } })
		table.insert(elements, { Background = { Color = colors[cell_no] } })
		table.insert(elements, { Text = " " .. text .. " " })
		table.insert(elements, "ResetAttributes") -- Reset attributes affect to next element
		num_cells = num_cells + 1
	end

	while #cells > 0 do
		local cell = table.remove(cells, 1)
		push(cell, #cells == 0)
	end

	window:set_right_status(wezterm.format(elements))
end)

return {
	animation_fps = 60,
	max_fps = 60,
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",

	-- color scheme
	-- color_scheme = "Operator Mono Dark",
	-- color_scheme = "Rosé Pine Moon (base16)",
	color_scheme = "Rosé Pine Moon (Gogh)",
	-- background
	-- window_background_opacity = 0.85,
	-- macos_window_background_blur = 20,
	window_decorations = "RESIZE",
	-- scrollbar
	enable_scroll_bar = true,
	adjust_window_size_when_changing_font_size = false,
	-- tab bar
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	tab_max_width = 100,
	-- window
	window_padding = {
		left = 5,
		right = 5,
		top = 5,
		bottom = 5,
	},
	colors = {
		tab_bar = {
			background = tabbar_bg,
		},
	},
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.4,
	},
}
