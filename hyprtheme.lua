-- Theme variables, migrated from hyprtheme.conf.
-- Returns a plain table; hyprland.lua pulls it in with require("hyprtheme").
-- Colors are ARGB strings ("0xAARRGGBB") because the Lua color parser only
-- accepts color *strings* (a numeric literal would be read as a decimal value).

return {
	-- Elements
	border_size = 1, -- theme knob; note general.border_size is overridden to 0 below
	gaps_in = 5,
	gaps_out = 10,
	gaps_ws = -20,
	rounding = 8,

	groupbar_font_family = "Iosevka",
	groupbar_font_size = 10,

	-- Colors
	gradient_angle = 45,

	active_border_col_1 = "0xFF89B4FA",
	active_border_col_2 = "0xFFF38BA8",
	inactive_border_col_1 = "0xFF28283d",
	inactive_border_col_2 = "0xFF32324d",

	active_shadow_col = "0x66000000",
	inactive_shadow_col = "0x66000000",

	group_border_active_col = "0xFFA6E3A1",
	group_border_inactive_col = "0xFFF9E2AF",
	group_border_locked_active_col = "0xFFF38BA8",
	group_border_locked_inactive_col = "0xFF89B4FA",

	groupbar_text_color = "0xFFCDD6F4",
}
