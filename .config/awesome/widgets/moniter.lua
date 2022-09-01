local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

moniter = {}

-- cpu temp
moniter.cpu_temp_chart = wibox.container {
	min_value = 0,
	max_value = 100,
	value = 30,
	forced_height = 100,
	forced_width = 100,
	colors = { beautiful.bg_focus },
	thickness = 10,
	start_angle = 0,			
	bg = beautiful.bg_normal,		
	widget = wibox.container.arcchart,
}

moniter.cpu_temp = wibox.container {
	moniter.cpu_temp_chart,
	forced_height = 100,
	forced_width = 100,
	widget = wibox.container.background,
}

moniter.cpu_temp_int_text = wibox.widget {
		valign = "center",
		align = "center",
        widget = wibox.widget.textbox,
}

moniter.cpu_temp_int = wibox.container {
	moniter.cpu_temp_int_text,
	--bg = "#04f40477",
	--forced_height = 100,
	--forced_width = 100,
	widget = wibox.container.background,
}

--[[
local cmd = 'bash -c "sensors | grep Package | cut -d \' \' -f 5 | cut -c 2-"'
awful.widget.watch(cmd, 1, function(widget, stdout) 
	moniter.cpu_chart = tonumber(stdout) 
	--widget:set_text(stdout)
	moniter.cpu_temp_int_text:set_text(stdout)
	end
)
--]]


local cpu = wibox.widget {
		color = beautiful.bg_focus,
		background_color = beautiful.bg_normal,
        max_value     = 1,
        value         = 0.2,
        forced_height = 20,
        forced_width  = 100,
        --paddings      = 1,
        --border_width  = 1,
        --border_color  = beautiful.border_color,
		shape		  = gears.shape.rounded_bar,
        widget        = wibox.widget.progressbar,
}


moniter.cpu_usage = wibox.container {
	cpu,
	height = 20,
    width  = 100,
	--direction = 'east',
	strategy = "min",
	widget = wibox.container.constraint,
}
moniter.cpu_usage:set_width(14)

local mem = wibox.widget {
		color = beautiful.bg_focus,
		background_color = beautiful.bg_normal,
        forced_height = 20,
        forced_width  = 100,
        max_value     = 1,
        value         = 0.2,
        --forced_height = 100,
        --forced_width  = 20,
        --paddings      = 1,
        --border_width  = 1,
        --border_color  = beautiful.border_color,
		shape		  = gears.shape.rounded_bar,
        widget        = wibox.widget.progressbar,
	}


moniter.mem_usage = wibox.container {
	mem,
	--forced_height = 18,
    --forced_width  = 140,
	--direction = 'east',
	widget = wibox.container.rotate,
}


local cmd = 'bash -c "./.config/awesome/scripts/cpu.sh"'
moniter.cpu_usage_percent = awful.widget.watch(cmd, 2, function(widget, stdout) 
	cpu.value = tonumber(stdout) 
	widget:set_text(math.floor(tonumber(stdout) * 100) .. "%") 
	end
)

local cmd = 'bash -c "./.config/awesome/scripts/mem.sh"'
moniter.mem_usage_percent = awful.widget.watch(cmd, 2, function(widget, stdout) 
	mem.value = tonumber(stdout) 
	widget:set_text(math.floor(tonumber(stdout) * 100 ) .. "%")
	end
)

local cmd = 'bash -c "./.config/awesome/scripts/temp.sh"'
awful.widget.watch(cmd, 2, function(widget, stdout) 
	moniter.cpu_temp_chart.value = tonumber(stdout) 
	moniter.cpu_temp_int_text:set_text(stdout:sub(1, -2) .. "°C")
	end
)

moniter.cpu_icon = wibox.widget {
	forced_width = 32,
	forced_height = 32,
	widget = wibox.widget.imagebox,
	image = beautiful.cpu_icon,
}

moniter.mem_icon = wibox.widget {
	forced_width = 32,
	forced_height = 32,
	widget = wibox.widget.imagebox,
	image = beautiful.mem_icon,
}

return moniter
