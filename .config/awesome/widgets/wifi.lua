local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")


wifi_image = wibox.widget.imagebox()
wifi_image:set_image(beautiful.wifi_high)


wifi = {}

cmd = "cat /proc/net/wireless | sed -n '3 p' | cut -d ' ' -f 6"

-- derived from https://awesomewm.org/recipes/wirelessStatus/
wifi.status = awful.widget.watch('bash -c "cat /proc/net/wireless | sed -n \'3 p\' | cut -d \' \' -f 6 | head -c -2"', 1,
		function(widget, stdout)
			if (stdout == "") 
			then
				wifi_image:set_image(beautiful.wifi_ds)
			else	
				quality = stdout * (10 / 7)

				if (quality <= 25) then
					wifi_image:set_image(beautiful.wifi_0)
				end
				if (quality <= 50) then
					wifi_image:set_image(beautiful.wifi_1)
				end
				if (quality <= 75) then
					wifi_image:set_image(beautiful.wifi_2)
				end
				if (quality > 75) then
					wifi_image:set_image(beautiful.wifi_3)
				end
				widget:set_text(quality)
		end
	end
)


-- iw dev

icon = wibox.container.margin(
	wifi_image, 
	3, 3, 3, 3
)

wifi.icon = icon

return wifi
