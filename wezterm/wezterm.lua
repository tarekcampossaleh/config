local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_cursor_style = "SteadyBlock"
config.automatically_reload_config = true
local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.default_cursor_style = "SteadyBlock"
config.automatically_reload_config = true
config.window_decorations = "RESIZE"
config.font_size = 16

config.keys = {
	-- Split horizontally (right)
	{
		key = "Return",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
	},
	-- Split vertically (down)
	{
		key = "Return",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
	},

	-- Move between panes with CMD + Arrow
	{
		key = "LeftArrow",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection "Left",
	},
	{
		key = "RightArrow",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection "Right",
	},
	{
		key = "UpArrow",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection "Up",
	},
	{
		key = "DownArrow",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection "Down",
	},
}

return config
