local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

moniter = {}

moniter.cpu_chart = wibox.container {
	min_value = 0,
	max_value = 100,
	value = 30,
	forced_height = 100,
	forced_width = 100,
	colors = { beautiful.bg_focus },
	thickness = 10,
	bg = "#ff0000",		
	widget = wibox.container.arcchart,
}


moniter.cpu_temp = wibox.container {
	moniter.cpu_chart,
	forced_height = 100,
	forced_width = 100,
	widget = wibox.container.background,
}

moniter.cpu_temp_int_text = wibox.widget {
		valign = "bottom",
		align = "center",

	forced_height = 100,
	forced_width = 100,
        widget = wibox.widget.textbox,
}

moniter.cpu_temp_int = wibox.container {
	moniter.cpu_temp_int_text,
	bg = "#04f40477",
	--forced_height = 100,
	--forced_width = 100,
	widget = wibox.container.background,
}

local cmd = 'bash -c "sensors | grep Package | cut -d \' \' -f 5 | cut -c 2-"'
awful.widget.watch(cmd, 1, function(widget, stdout) 
	moniter.cpu_chart = tonumber(stdout) 
	--widget:set_text(stdout)
	moniter.cpu_temp_int_text:set_text(stdout)
	end
)

-- source: https://stackoverflow.com/questions/9229333/how-to-get-overall-cpu-usage-e-g-57-on-linux
--local cmd = 'bash -c "awk \'{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) \"%\"; }\' <(grep \'cpu \' /proc/stat) <(sleep 1;grep \'cpu \' /proc/stat)"'

local cpu = wibox.widget {
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

return moniter
