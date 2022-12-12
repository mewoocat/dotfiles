
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local tray = {}



--systray widget
mysystray = wibox.widget.systray()
mysystray = wibox.container.margin(wibox.widget.systray(), 9, 9, 9, 9)
--mysystray:set_base_size(10)
mysystray.visible = false

tray.systray = mysystray



local shape = function(cr, width, height)
	gears.shape.transform(gears.shape.isosceles_triangle(cr, 20, 18))
end

local icon = wibox.widget {
	widget = wibox.container.background,
	--shape = gears.shape.triangle,
	bg = beautiful.fg_normal,
	forced_width = 44,
	forced_height = 44,
}

icon:set_shape(shape)

local icon = wibox.widget {
	widget = wibox.widget.imagebox,
	image = beautiful.triangle_icon,
}

icon = wibox.container.rotate(icon, "north")
tray.button = wibox.container.margin(icon, 12, 12, 12, 12)
tray.button = wibox.container.background(tray.button, "#00000000")

local bg
function Swap(mode)
	if (mode == "on") then
		bg = tray.button.bg
		--fg = tray.button.fg
		tray.button.bg = beautiful.bg_focus	
		--tray.button.fg = beautiful.bg_normal
	else
		tray.button.bg = bg
	end
end

function tray.toggleMenu() 
	if (tray.systray.visible == true)
	then 
		tray.systray.visible = false
		icon.direction = "north"
	else 
		tray.systray.visible = true
		icon.direction = "west"
	end
end

tray.button:connect_signal("mouse::enter", function() Swap("on") end)
tray.button:connect_signal("mouse::leave", function() Swap() end)
tray.button:connect_signal("button::press", function() tray.toggleMenu() end)

return tray
