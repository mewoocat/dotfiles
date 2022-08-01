
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")

local brightness = {}


brightness.slider = wibox.widget {
	bar_shape = gears.shape.rounded_rect,
	bar_height          = 10,
	bar_color           = beautiful.fg_normal,
	handle_color        = beautiful.bg_focus,
	handle_shape        = gears.shape.circle,
	handle_border_color = beautiful.border_color,
	handle_border_width = 8,
	value               = 25,
	forced_height		= 48,
	forced_width		= 60,
	widget              = wibox.widget.slider,
}

-- sets brightness slider value on start
awful.spawn.easy_async("light", function(stdout)
	brightness.slider["value"] = tonumber(stdout)
end)

-- Connect to `property::value` to use the value on change
brightness.slider:connect_signal("property::value", function(_, new_value)
	awful.spawn.with_shell("light -S " .. tostring(new_value))
end)

return brightness
