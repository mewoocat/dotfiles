local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

battery_image = wibox.widget.imagebox()

battery_icon = wibox.container.margin(
	battery_image,
	9, 9, 9, 9
)


battery = awful.widget.watch('acpi', 1,
		function(widget, stdout)
			output = {}
			for i in stdout:gmatch("[^%s]+") do
				table.insert(output, i)
			end
			widget:set_text(output[4]:sub(0, -2))
			if (output[3] ~= "Discharging,") then
				battery_image:set_image(beautiful.bat_charging)	
			end
			if (output[3] == "Discharging,") then
				battery_image:set_image(beautiful.battery_icon)
			end
		end
)


--mybattery = wibox.widget.textbox("test")
mybattery = wibox.container.margin(
	 battery,
	 9, 9, 9, 9
)
