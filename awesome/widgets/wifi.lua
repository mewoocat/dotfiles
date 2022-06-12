local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")


wifi_image = wibox.widget.imagebox()
wifi_image:set_image(beautiful.wifi_high)


wifi_text = wibox.widget.textbox()
wifi_text.text = "wifi"

cmd = "cat /proc/net/wireless | sed -n '3 p' | cut -d ' ' -f 6"

-- derived from https://awesomewm.org/recipes/wirelessStatus/
wifi_status = awful.widget.watch('bash -c "cat /proc/net/wireless | sed -n \'3 p\' | cut -d \' \' -f 6 | head -c -2"', 1,
		function(widget, stdout)
			if (stdout == "") 
			then
				wifi_image:set_image(beautiful.wifi_disconnected)
			else	
				quality = stdout * (10 / 7)
				if (quality > 60) then
					wifi_image:set_image(beautiful.wifi_high)
				end
				if (quality <= 60) then
					wifi_image:set_image(beautiful.wifi_mid)
				end
				widget:set_text(quality)
		end
	end
)


-- iw dev

wifi = wibox.container.margin(
	wifi_image, 
	9, 9, 9, 9
)
