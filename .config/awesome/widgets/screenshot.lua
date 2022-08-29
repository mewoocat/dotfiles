local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")

local button = require("widgets/button")

local screenshot = {}

local icon = wibox.widget.imagebox()
icon:set_image(beautiful.moon)
button_margin = wibox.container.margin(icon, 30, 30, 30, 30)
button_bg = wibox.container {
	button_margin, 
	bg = "#00000000",
	shape        = gears.shape.rounded_rect,
	widget = wibox.container.background,
}

button_bg:connect_signal("mouse::enter", function() button:hoverOn(button_bg) end)
button_bg:connect_signal("mouse::leave", function() button:hoverOff(button_bg) end)

screenshot.button = wibox.container {
	button_bg,
	valign = center,
	halign = center,
	widget = wibox.container.place,
}

return screenshot
