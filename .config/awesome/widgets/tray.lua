
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local tray = {}



--systray widget
mysystray = wibox.widget.systray()
mysystray = wibox.container.margin(wibox.widget.systray(), 9, 9, 9, 9)
--mysystray:set_base_size(10)

tray.systray = mysystray



local shape = function(cr, width, height)
	gears.shape.transform(gears.shape.isosceles_triangle(cr, 20, 18))
end

local icon = wibox.widget {
	widget = wibox.container.background,
	--shape = gears.shape.triangle,
	bg = "#ffffff",
	forced_width = 20,
	forced_height = 20,
}

icon:set_shape(shape)


icon = wibox.container.rotate(icon, "south")
tray.button = wibox.container.margin(icon, 9, 9, 9, 9)
tray.button = wibox.container.background(tray.button, "#00000000")

local bg
function Swap(mode)
	if (mode == "on") then
		bg = tray.button.bg
		tray.button.bg = beautiful.bg_focus	
	else
		tray.button.bg = bg
	end
end

function tray.toggleMenu() 
	if (tray.systray.visible == true)
	then 
		tray.systray.visible = false
	else 
		tray.systray.visible = true
	end
end

tray.button:connect_signal("mouse::enter", function() Swap("on") end)
tray.button:connect_signal("mouse::leave", function() Swap() end)
tray.button:connect_signal("button::press", function() tray.toggleMenu() end)

return tray
