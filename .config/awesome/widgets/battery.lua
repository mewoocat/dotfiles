local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local battery = {}

battery_image = wibox.widget.imagebox()

battery.icon = wibox.container.margin(
	battery_image,
	7, 7, 7, 7
)

battery.percent = awful.widget.watch('acpi', 1,
		function(widget, stdout)
			output = {}
			for i in stdout:gmatch("[^%s]+") do
				table.insert(output, i)
			end
			widget:set_text(output[4]:sub(0, -2))
			if (output[3] ~= "Discharging,") then
				battery_image:set_image(beautiful.bat_charging)	
			end
			if (output[3] == "Not") then
				battery_image:set_image(beautiful.bat_charging)	
				widget:set_text("100%")
			end
			if (output[3] == "Discharging,") then
				battery_image:set_image(beautiful.battery_icon)
			end
		end
)

local timeCMD = 'bash -c "acpi | awk \'{print $5}\'"'
battery.time = awful.widget.watch(timeCMD, 1,
		function(widget, stdout)
			output = {}
			widget:set_text(stdout)
		end
)

battery.menuWidget = {
	widget = wibox.container.background,
	--forced_height = 200,
	bg = beautiful.bg_alt,
    shape  = gears.shape.rounded_rect,

	{
		widget = battery.time
	}
}

return battery
