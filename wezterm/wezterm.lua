local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
	default_cursor_style = "SteadyBlock",
	automatically_reload_config = true,
	window_decorations = "RESIZE",
	font_size = 16,
}

return config
