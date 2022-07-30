
local wibox = require("wibox")
local beautiful = require("beautiful")

local tray = {}



--systray widget
mysystray = wibox.widget.systray()
mysystray = wibox.container.margin(wibox.widget.systray(), 9, 9, 9, 9)
--mysystray:set_base_size(10)

tray.systray = mysystray



--icon = wibox.widget {
--	text = "hii",
--	widget = wibox.widget.textbok
--}
icon = wibox.widget.imagebox()
icon:set_image(beautiful.circle)

tray.button = wibox.container.margin(icon, 9, 9, 9, 9)
tray.button = wibox.container.background(tray.button, "#00000000")

tray.image = icon

return tray
