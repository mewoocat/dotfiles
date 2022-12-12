local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

audio = {}

-- volume icon
local image = wibox.widget.imagebox()
audio.icon = wibox.container.margin(
	image,
	5, 5, 5, 5
)

-- volume percentage
audio.level_text = wibox.widget.textbox()
awful.spawn.easy_async("pamixer --get-volume", function(stdout)
	audio.level_text.text = stdout:sub(0, -2) .. "%"
	
end)
audio.level = wibox.container.margin(
	--awful.widget.watch('pamixer --get-volume', 1),
	audio.level_text,
	2, 2, 2, 2
)



function audio.setIcon()
	image:set_image(beautiful.vol_high)
end

audio.setIcon()

function audio.up()
	awful.spawn.easy_async("pamixer --get-volume", function(stdout)
		audio.slider["value"] = tonumber(stdout)
	end)
end

function audio.volumeDown()
	
end




-- volume slider widget
audio.slider = wibox.widget {
	bar_shape = gears.shape.rounded_rect,
	bar_height          = 10,
	bar_color           = beautiful.fg_normal,
	handle_color        = beautiful.bg_focus,
	handle_shape        = gears.shape.circle,
	handle_border_color = beautiful.border_color,
	handle_border_width = 0,
	handle_width		= 40,
	handle_margins		= 0,
	value               = 25,
	forced_height		= 60,
	--forced_width		= 60,
	widget              = wibox.widget.slider,
}

-- sets volume slider value on start
awful.spawn.easy_async("pamixer --get-volume", function(stdout)
	audio.slider["value"] = tonumber(stdout)
end)

-- Connect to `property::value` to use the value on change
audio.slider:connect_signal("property::value", function(_, new_value)
    --naughty.notify { title = "Slider changed", message = tostring(new_value) }
	awful.spawn.with_shell("pamixer --set-volume " .. tostring(new_value))	
end)


return audio
