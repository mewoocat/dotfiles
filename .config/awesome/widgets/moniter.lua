local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

moniter = {}

moniter.cpu_temp = awful.widget.watch('bash -c "sensors | grep Package | cut -d \' \' -f 5 | cut -c 2-"', 1)
--[[
local cmd = 'bash -c ""top -bn1 | grep "Cpu(s)" | '\\'
           sed "s/.*, *'\\'([0-9.]*'\\')%* id.*/'\\'1/" | '\\'
           awk '{print 100 - $1"%"}''
moniter.cpu_usage_percent = awful.widget.watch(cmd, 1)
--]]
moniter.cpu_usage = wibox.container {
	{
        max_value     = 1,
        value         = 0.2,
        --forced_height = 100,
        --forced_width  = 20,
        --paddings      = 1,
        --border_width  = 1,
        --border_color  = beautiful.border_color,
		shape		  = gears.shape.rounded_bar,
        widget        = wibox.widget.progressbar,
	},
	forced_height = 100,
    forced_width  = 20,
	direction = 'east',
	widget = wibox.container.rotate,
}

return moniter
