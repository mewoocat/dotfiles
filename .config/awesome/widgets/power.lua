local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")


local power = {}

power.power_button = wibox.container {
	{	
		{
			widget = wibox.widget.imagebox,
			image = beautiful.power,
			forced_height = 40,

		},
		widget = wibox.container.margin,
		margins = 10,
	},
	widget = wibox.container.background,
	shape = gears.shape.circle,
}

return power
