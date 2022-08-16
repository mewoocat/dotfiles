local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local user = {}

user.name = wibox.widget {
	valign = "center",
	halign = "center",
	widget = wibox.widget.textbox,
}

awful.spawn.easy_async_with_shell("echo $USER", function(stdout) 
	user.name.text = stdout:sub(1, -2) 
end)

user.pfp = wibox.widget {
	{
		forced_height = 40,
		forced_width = 40,
		image = pfp,
		widget = wibox.widget.imagebox
	},
	widget = wibox.container.background,
	shape = gears.shape.circle,
}

return user
