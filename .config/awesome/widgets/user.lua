local wibox = require("wibox")
local awful = require("awful")

local user = {}

user.name = wibox.widget {
	widget = wibox.widget.textbox,
}

awful.spawn.easy_async_with_shell("echo $USER", function(stdout) 
	user.name.text = stdout 
end)

return user
