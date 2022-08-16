
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")

local launcher = {}


-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
  -- { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

local launcher_icon = wibox.widget.imagebox()
launcher_icon:set_image(beautiful.launcher_icon)
local launcher_icon = wibox.container.margin(launcher_icon, 10, 20, 6, 6)
launcher.mylauncher = wibox.container.background(launcher_icon, "#00000000")
--mylauncher.shape = gears.shape.rounded_rect
launcher.mylauncher:connect_signal("button::press", function() awful.spawn("rofi -show drun") end)

local bg
function gSwap(mode)
	if (mode == "on") then
		bg = launcher.mylauncher.bg 
		launcher.mylauncher.bg = beautiful.bg_focus	
	else
		launcher.mylauncher.bg = bg
	end
end

launcher.mylauncher:connect_signal("mouse::enter", function() gSwap("on") end)
launcher.mylauncher:connect_signal("mouse::leave", function() gSwap() end)



return launcher
