local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local button = require("widgets/button")


local wifi_image = wibox.widget.imagebox()
wifi_image:set_image(beautiful.wifi_high)


local wifi = {}

local b_icon = wibox.widget.imagebox()
b_icon:set_image(beautiful.bars)
local button_margin = wibox.container.margin(b_icon, 20, 20, 20, 20)
local button_bg = wibox.container {
	button_margin, 
	bg = "#00000000",
	shape        = gears.shape.rounded_rect,
	widget = wibox.container.background,
}

button_bg:connect_signal("mouse::enter", function() button:hoverOn(button_bg) end)
button_bg:connect_signal("mouse::leave", function() button:hoverOff(button_bg) end)

wifi.button = wibox.container {
	button_bg,
	valign = center,
	halign = center,
	widget = wibox.container.place,
}

cmd = "cat /proc/net/wireless | sed -n '3 p' | cut -d ' ' -f 6"

-- derived from https://awesomewm.org/recipes/wirelessStatus/
wifi.status = awful.widget.watch('bash -c "cat /proc/net/wireless | sed -n \'3 p\' | cut -d \' \' -f 6 | head -c -2"', 1,
		function(widget, stdout)
			if (stdout == "") 
			then
				wifi_image:set_image(beautiful.wifi_ds)
				b_icon:set_image(beautiful.wifi_ds)
			else	
				quality = stdout * (10 / 7)

				if (quality <= 25) then
					wifi_image:set_image(beautiful.wifi_0)
					b_icon:set_image(beautiful.wifi_0)
				end
				if (quality <= 50) then
					wifi_image:set_image(beautiful.wifi_1)
					b_icon:set_image(beautiful.wifi_1)
				end
				if (quality <= 75) then
					wifi_image:set_image(beautiful.wifi_2)
					b_icon:set_image(beautiful.wifi_2)
				end
				if (quality > 75) then
					wifi_image:set_image(beautiful.wifi_3)
					b_icon:set_image(beautiful.wifi_3)
				end
				widget:set_text(quality)
		end
	end
)


-- iw dev

wifi.icon = wibox.container.margin(
	wifi_image, 
	3, 3, 3, 3
)


wifi.ssid = wibox.widget {
	widget = wibox.widget.textbox,
}

awful.spawn.easy_async_with_shell("iwgetid -r", function(stdout) 
	wifi.ssid.text = stdout 
end)




return wifi
