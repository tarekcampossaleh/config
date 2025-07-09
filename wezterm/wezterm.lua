local wezterm = require("wezterm")
local tabs = require("utils.tabs")
-- TODO: Move to a offline local version
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

local config = wezterm.config_builder()

config.automatically_reload_config = true
config.check_for_updates = true
config.check_for_updates_interval_seconds = 86400

config.default_cursor_style = "SteadyBlock"
config.window_decorations = "RESIZE"

config.font_size = 14
config.font = wezterm.font("SF Mono")
config.color_scheme = 'Tokyo Night Moon'

-- https://wezfurlong.org/wezterm/config/lua/config/window_padding.html
config.window_padding = {
	left = 4,
	right = 4,
	top = 1,
	bottom = 1,
}

-- https://wezfurlong.org/wezterm/config/appearance.html
config.window_background_opacity = 0.85 -- 0.4
config.text_background_opacity = 1.0    -- 0.9

-- Apply tabs style
tabs(config)

workspace_switcher.apply_to_config(config)
workspace_switcher.zoxide_path = "/opt/homebrew/bin/zoxide"

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

	-- Workspace switcher
	{
		key = "s",
		mods = "CMD",
		action = workspace_switcher.switch_workspace(),
	},
	{
		key = "S",
		mods = "CMD",
		action = workspace_switcher.switch_to_prev_workspace(),
	} }


return config
