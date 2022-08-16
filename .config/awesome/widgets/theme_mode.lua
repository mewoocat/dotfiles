local wibox = require("wibox")
local beautiful = require("beautiful")
local button = require("widgets/button")
local gears = require("gears")


local theme_mode = {}

theme_mode.button = wibox.container {
	{
		{
			image = beautiful.circle,
			widget = wibox.widget.imagebox,
		},
		margins = 24,
		widget = wibox.container.margin
	},
	shape        = gears.shape.rounded_rect,
	widget = wibox.container.background,
}

theme_mode.button:connect_signal("mouse::enter", function() button:hoverOn(theme_mode.button) end)
theme_mode.button:connect_signal("mouse::leave", function() button:hoverOff(theme_mode.button) end)

return theme_mode
