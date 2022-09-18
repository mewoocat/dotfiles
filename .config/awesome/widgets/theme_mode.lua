local wibox = require("wibox")
local beautiful = require("beautiful")
local button = require("widgets/button")
local gears = require("gears")
local awful = require("awful")

local script_path = ".config/awesome/scripts/"

local theme_mode = {}

theme_mode.button = wibox.container {
	{
		{
			image = beautiful.circle,
			widget = wibox.widget.imagebox,
		},
		margins = 24,
		widget = wibox.container.margin
	},
	shape        = gears.shape.rounded_rect,
	widget = wibox.container.background,
}

function theme_mode.toggleTheme() 
	local user = require("user_variables")
	if (user.theme == "dark") then
		awful.spawn.with_shell(script_path.."theme.sh -l")
		user.theme = "light"
	else
		awful.spawn.with_shell(script_path.."theme.sh -d")
		user.theme = "dark"
	end
end

theme_mode.button:connect_signal("mouse::enter", function() button:hoverOn(theme_mode.button) end)
theme_mode.button:connect_signal("mouse::leave", function() button:hoverOff(theme_mode.button) end)
theme_mode.button:connect_signal("button::press", function() theme_mode.toggleTheme() end)

return theme_mode
