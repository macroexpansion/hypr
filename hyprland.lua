-- Hyprland configuration, migrated from hyprland.conf to Lua (Hyprland 0.55+).
-- Only options that differ from current Hyprland defaults are set here; everything
-- else inherits the default. Theme values (gaps, colors, fonts) live in hyprtheme.lua.
-- The old hyprland.conf / hyprtheme.conf are left in place as a backup and are
-- ignored by Hyprland as long as this .lua file exists.

local theme = require("hyprtheme")

--------------------------------------------------------------------------------
-- Environment variables
--------------------------------------------------------------------------------

hl.env("TERMINAL", "ghostty")

-- Multi-GPU: render on card2, hardware-accelerate on card1.
hl.env("WLR_DRM_DEVICES", "/dev/dri/card2:/dev/dri/card1")
hl.env("AQ_DRM_DEVICES", "/dev/dri/card2:/dev/dri/card1")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("NVD_BACKEND", "direct")

--------------------------------------------------------------------------------
-- Monitors
--------------------------------------------------------------------------------

hl.monitor({ output = "", mode = "highres", position = "auto", scale = 1.33 })

--------------------------------------------------------------------------------
-- Config (non-default values only)
--------------------------------------------------------------------------------

hl.config({
	general = {
		border_size = 0,
		gaps_in = theme.gaps_in,
		gaps_out = theme.gaps_out,
		-- NOTE: gaps_workspaces now has a minimum of 0; the old -20 will be clamped.
		gaps_workspaces = theme.gaps_ws,
		resize_on_border = true,
		layout = "master",

		col = {
			active_border = {
				colors = { theme.active_border_col_1, theme.active_border_col_2 },
				angle = theme.gradient_angle,
			},
			inactive_border = {
				colors = { theme.inactive_border_col_1, theme.inactive_border_col_2 },
				angle = theme.gradient_angle,
			},
			nogroup_border_active = theme.group_border_active_col,
		},
	},

	decoration = {
		rounding = theme.rounding,
		active_opacity = 0.83,
		inactive_opacity = 0.73,

		blur = {
			size = 5,
			passes = 2,
			brightness = 0.8172,
			popups = true,
		},

		shadow = {
			range = 25,
			color = theme.active_shadow_col,
			color_inactive = theme.inactive_shadow_col,
		},
	},

	animations = {
		enabled = false,
	},

	input = {
		repeat_rate = 30,
		repeat_delay = 200,
		sensitivity = 1.0,
		accel_profile = "adaptive",
		scroll_method = "2fg",
	},

	group = {
		col = {
			border_active = theme.group_border_active_col,
			border_inactive = theme.group_border_inactive_col,
			border_locked_active = theme.group_border_locked_active_col,
			border_locked_inactive = theme.group_border_locked_inactive_col,
		},
		groupbar = {
			gradients = true,
			font_family = theme.groupbar_font_family,
			font_size = theme.groupbar_font_size,
			text_color = theme.groupbar_text_color,
			col = {
				active = theme.group_border_active_col,
				inactive = theme.group_border_inactive_col,
				locked_active = theme.group_border_locked_active_col,
				locked_inactive = theme.group_border_locked_inactive_col,
			},
		},
	},

	misc = {
		disable_hyprland_logo = true,
		force_default_wallpaper = 0,
		focus_on_activate = true,
		background_color = "0x000000",
		font_family = theme.groupbar_font_family,
		splash_font_family = theme.groupbar_font_family,
		col = {
			splash = theme.groupbar_text_color,
		},
	},

	binds = {
		workspace_center_on = 0,
		movefocus_cycles_fullscreen = true,
	},

	xwayland = {
		force_zero_scaling = true,
	},

	cursor = {
		no_hardware_cursors = false,
		no_break_fs_vrr = false,
		hotspot_padding = 1,
		hide_on_touch = false,
		use_cpu_buffer = false,
	},

	debug = {
		disable_logs = false,
	},

	dwindle = {
		special_scale_factor = 0.8,
	},

	master = {
		special_scale_factor = 0.8,
	},
})

--------------------------------------------------------------------------------
-- Window rules
--------------------------------------------------------------------------------

-- Keep these windows fully opaque (active and inactive).
hl.window_rule({
	name = "opaque-browsers",
	match = { class = "brave-browser|google-chrome" },
	opacity = "1.0 1.0",
})
-- hl.window_rule({
-- 	name = "opaque-steam-apps",
-- 	match = { class = "^(steam_app_.*)$" },
-- 	opacity = "1.0 1.0",
-- })
-- hl.window_rule({
-- 	name = "opaque-dota2",
-- 	match = { class = "^(dota2.*)$" },
-- 	opacity = "1.0 1.0",
-- })
hl.window_rule({
	name = "centered-steam-games",
	match = { class = "^(steam_app_.*|dota2.*|Clair.*)$" },
	float = true,
	center = true,
	size = "75% 75%",
	suppress_event = "fullscreen",
	opacity = "1.0 1.0",
})

--------------------------------------------------------------------------------
-- Programs
--------------------------------------------------------------------------------

local scripts = "~/.config/hypr/scripts"

local ghostty = "/usr/bin/ghostty"
local files = "thunar"
local editor = "geany"
local browser = "firefox"
local colorpicker = scripts .. "/colorpicker"
local screenshot = scripts .. "/screenshot"
local lockscreen = scripts .. "/lockscreen"

local rofi_launcher = scripts .. "/rofi_launcher"
local rofi_runner = scripts .. "/rofi_runner"
local rofi_asroot = scripts .. "/rofi_asroot"
local rofi_music = scripts .. "/rofi_music"
local rofi_network = scripts .. "/rofi_network"
local rofi_bluetooth = scripts .. "/rofi_bluetooth"
local rofi_powermenu = scripts .. "/rofi_powermenu"
local rofi_screenshot = scripts .. "/rofi_screenshot"

local notifycmd = "notify-send -h string:x-canonical-private-synchronous:hypr-cfg -u low"

--------------------------------------------------------------------------------
-- Keybindings
--------------------------------------------------------------------------------

-- Terminal & apps
hl.bind("SUPER + Return", hl.dsp.exec_cmd(ghostty))
hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd(files))
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd(editor))
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd(browser))

-- Rofi menus
hl.bind("SUPER + D", hl.dsp.exec_cmd(rofi_launcher))
hl.bind("ALT + F2", hl.dsp.exec_cmd(rofi_runner))
hl.bind("SUPER + R", hl.dsp.exec_cmd(rofi_asroot))
hl.bind("SUPER + M", hl.dsp.exec_cmd(rofi_music))
hl.bind("SUPER + N", hl.dsp.exec_cmd(rofi_network))
hl.bind("SUPER + B", hl.dsp.exec_cmd(rofi_bluetooth))
hl.bind("SUPER + X", hl.dsp.exec_cmd(rofi_powermenu))
hl.bind("SUPER + A", hl.dsp.exec_cmd(rofi_screenshot))

-- Misc
hl.bind("SUPER + P", hl.dsp.exec_cmd(colorpicker))
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd("hyprlock"))

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd(screenshot .. " --now"))
hl.bind("ALT + Print", hl.dsp.exec_cmd(screenshot .. " --in5"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(screenshot .. " --in10"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd(screenshot .. " --win"))
hl.bind("SUPER + Print", hl.dsp.exec_cmd(screenshot .. " --area"))

-- Window management
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("CTRL + ALT + Delete", hl.dsp.exit())
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + Space", function()
	hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
	hl.dispatch(hl.dsp.window.center())
end)

-- Move focus
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

-- Move active window
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- Resize active window (repeats while held)
hl.bind("SUPER + CTRL + H", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + L", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + K", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + J", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

-- Cycle through windows
hl.bind("SUPER + Tab", function()
	hl.dispatch(hl.dsp.window.cycle_next())
	hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Switch / send to workspaces 1-9
for i = 1, 9 do
	hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Seamless workspace switching
hl.bind("CTRL + ALT + left", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("CTRL + ALT + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("CTRL + ALT + SHIFT + left", hl.dsp.window.move({ workspace = "e-1" }))
hl.bind("CTRL + ALT + SHIFT + right", hl.dsp.window.move({ workspace = "e+1" }))

-- Misc window actions
-- hl.bind("SUPER + SHIFT + P", function()
-- 	hl.dispatch(hl.dsp.window.pin())
-- 	hl.exec_cmd(notifycmd .. " 'Toggled Pin'")
-- end)
-- hl.bind("SUPER + SHIFT + S", hl.dsp.window.swap({ next = true }))

-- Lock on lid close
-- hl.bind("switch:Lid Switch", hl.dsp.exec_cmd(lockscreen), { locked = true })

--------------------------------------------------------------------------------
-- Autostart
--------------------------------------------------------------------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("wl-clip-persist --clipboard regular")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd(scripts .. "/startup") -- kills waybar and mako first
	hl.exec_cmd("waybar")
end)
