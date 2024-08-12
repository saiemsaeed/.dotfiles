local wezterm = require("wezterm")

local config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	color_scheme = "Gruvbox Dark (Gogh)",
	font = wezterm.font("JetBrains Mono", { weight = "Regular" }),
	font_size = 19.5,
	-- window_background_opacity = 0.9,
	-- macos_window_background_blur = 10,
	window_padding = {
		left = 3,
		right = 3,
		top = 0,
		bottom = 0,
	},
	enable_kitty_keyboard = true,
}

return config
