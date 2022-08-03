local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

moniter = {}
local cmd = 'bash -c "sensors | grep Package | cut -d \' \' -f 5 | cut -c 2-"'
moniter.cpu_temp = awful.widget.watch(cmd, 1)

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

local cmd = 'bash -c "./.config/awesome/scripts/cpu.sh"'
moniter.cpu_usage_percent = awful.widget.watch(cmd, 2, function(widget, stdout) 
	cpu.value = tonumber(stdout) 
	widget:set_text(stdout) 
	end
)

return moniter
