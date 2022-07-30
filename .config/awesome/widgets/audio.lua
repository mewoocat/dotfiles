local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")

local audio = {}

vol_image = wibox.widget.imagebox()

audio.icon = wibox.container.margin(
	vol_image,
	5, 5, 5, 5
)

vol_image:set_image(beautiful.vol_high)


level = wibox.widget.textbox()
awful.spawn.easy_async("pamixer --get-volume", function(stdout)
	level.text = stdout:sub(0, -2) .. "%"
end)
myaudio = wibox.container.margin(
	--awful.widget.watch('pamixer --get-volume', 1),
	level,
	2, 2, 2, 2
)

audio.level = myaudio

return audio
