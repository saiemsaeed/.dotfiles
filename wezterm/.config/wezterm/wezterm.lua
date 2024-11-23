local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

wezterm.on("switch-to-left", function(window, pane)
	local tab = window:mux_window():active_tab()

	if tab:get_pane_direction("Left") ~= nil then
		window:perform_action(wezterm.action.ActivatePaneDirection("Left"), pane)
	else
		window:perform_action(wezterm.action.ActivateTabRelative(-1), pane)
	end
end)

wezterm.on("switch-to-right", function(window, pane)
	local tab = window:mux_window():active_tab()

	if tab:get_pane_direction("Right") ~= nil then
		window:perform_action(wezterm.action.ActivatePaneDirection("Right"), pane)
	else
		window:perform_action(wezterm.action.ActivateTabRelative(1), pane)
	end
end)

local function mapkeys()
	local keys = "spa" -- no c,v
	local keymappings = {}

	for i = 1, #keys do
		local c = keys:sub(i, i)
		table.insert(keymappings, {
			key = c,
			mods = "CMD",
			action = act.SendKey({
				key = c,
				mods = "CTRL",
			}),
		})
	end

	for i = 1, 9 do
		table.insert(keymappings, {
			key = i .. "",
			mods = "CMD",
			action = act.ActivateTab(i - 1),
		})
	end

	-- table.insert(keymappings, {
	-- 	key = "h",
	-- 	mods = "CTRL",
	-- 	action = wezterm.action.EmitEvent("switch-to-left"),
	-- })
	-- table.insert(keymappings, {
	-- 	key = "j",
	-- 	mods = "CTRL",
	-- 	action = wezterm.action.ActivatePaneDirection("Down"),
	-- })
	-- table.insert(keymappings, {
	-- 	key = "k",
	-- 	mods = "CTRL",
	-- 	action = wezterm.action.ActivatePaneDirection("Up"),
	-- })
	-- table.insert(keymappings, {
	-- 	key = "l",
	-- 	mods = "CTRL",
	-- 	action = wezterm.action.EmitEvent("switch-to-right"),
	-- })

	return keymappings
end

config = {
	automatically_reload_config = true,
	-- enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	color_scheme = "Gruvbox Dark (Gogh)",
	font = wezterm.font("JetBrains Mono", { weight = "Regular" }),
	font_size = 18,
	-- This is the key configuration:
	keys = mapkeys(),
	-- window_background_opacity = 0.9,
	-- macos_window_background_blur = 10,
	window_padding = {
		left = 3,
		right = 3,
		top = 0,
		bottom = 0,
	},

	-- enable_kitty_keyboard = true,
}

return config
