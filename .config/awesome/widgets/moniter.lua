local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

moniter = {}

moniter.cpu_temp_chart = wibox.container {
	min_value = 0,
	max_value = 100,
	value = 30,
	forced_height = 100,
	forced_width = 100,
	colors = { beautiful.bg_focus },
	thickness = 10,
						
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
--	forced_height = 100,
--	forced_width = 100,
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
        --forced_height = 100,
        --forced_width  = 20,
        --paddings      = 1,
        --border_width  = 1,
        --border_color  = beautiful.border_color,
		shape		  = gears.shape.rounded_bar,
        widget        = wibox.widget.progressbar,
}


moniter.cpu_usage = wibox.container {
	cpu,
	forced_height = 100,
    forced_width  = 20,
	direction = 'east',
	widget = wibox.container.rotate,
}

local mem = wibox.widget {
		color = beautiful.bg_focus,
		background_color = beautiful.bg_normal,
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
	forced_height = 100,
    forced_width  = 20,
	direction = 'east',
	widget = wibox.container.rotate,
}


local cmd = 'bash -c "./.config/awesome/scripts/cpu.sh"'
moniter.cpu_usage_percent = awful.widget.watch(cmd, 2, function(widget, stdout) 
	cpu.value = tonumber(stdout) 
	widget:set_text(stdout) 
	end
)

local cmd = 'bash -c "./.config/awesome/scripts/mem.sh"'
moniter.mem_usage_percent = awful.widget.watch(cmd, 2, function(widget, stdout) 
	mem.value = tonumber(stdout) 
	widget:set_text(stdout) 
	end
)

local cmd = 'bash -c "./.config/awesome/scripts/temp.sh"'
awful.widget.watch(cmd, 2, function(widget, stdout) 
	moniter.cpu_temp_chart.value = tonumber(stdout) 
	moniter.cpu_temp_int_text:set_text(stdout:sub(1, -2) .. "°C")
	end
)

return moniter
