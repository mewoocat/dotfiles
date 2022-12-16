local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")

local battery = {}

--battery_image = wibox.widget.imagebox()
battery_border = wibox.widget.imagebox()
battery_border:set_image(beautiful.battery_empty)

battery_amount = wibox.widget.imagebox()
battery_amount:set_image(beautiful.battery_75)

--[[
battery.icon = wibox.container.margin(
	battery_image,
	7, 7, 7, 7
)
]]

battery.icon = wibox.widget{
	{
		battery_border,
		battery_amount,
		layout = wibox.layout.stack,
	},
	margins = 6,
	widget = wibox.container.margin,
}


battery.percent = awful.widget.watch('acpi', 1,
		function(widget, stdout)
			output = {}
			for i in stdout:gmatch("[^%s]+") do
				table.insert(output, i)
			end

			--widget:set_text(tostring(output[5]))
			--widget:set_text(output[4]:sub(0, -2))
		
			-- If charged
			if (output[3] == "Not") then
				battery_amount:set_image(beautiful.battery_charging_amount)
				battery_border:set_image(beautiful.battery_charging_frame)	
				widget:set_text("100%")
			
			elseif (output[3] == "Charging,") then
				battery_amount:set_image(beautiful.battery_charging_amount)
				battery_border:set_image(beautiful.battery_charging_frame)
				local percent = tonumber(output[4]:sub(0,-3))
				widget:set_text(tostring(percent) .. "%")
			
			-- If not plugged in
			elseif (output[3] == "Discharging,") then
				--battery_image:set_image(beautiful.battery_icon)
				battery_border:set_image(beautiful.battery_empty)
				local percent = tonumber(output[4]:sub(0,-3))
				widget:set_text(tostring(percent) .. "%")
				if (percent > 75) then
					battery_amount:set_image(beautiful.battery_full)
				end
				if (percent <= 75 and percent > 50 ) then
					battery_amount:set_image(beautiful.battery_75)
				end
				if (percent <= 50 and percent > 25) then
					battery_amount:set_image(beautiful.battery_50)
				end
				if (percent <= 25) then
					battery_amount:set_image(beautiful.battery_25)
				end

			else
				widget:set_text("error")
				battery_amount:set_image(beautiful.moon)

				--naughty.notify({ preset = naughty.config.presets.critical, title = "debug", text = tostring(percent)})
			end
			--naughty.notify({text = tostring(output[4])})
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
