
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")


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

launcher_icon = wibox.widget.imagebox()
launcher_icon:set_image(beautiful.launcher_icon)
launcher_icon = wibox.container.margin(launcher_icon, 6, 6, 6, 6)
mylauncher = wibox.container.background(launcher_icon, "#00000000")
--mylauncher.shape = gears.shape.rounded_rect
mylauncher:connect_signal("button::press", function() awful.spawn("rofi -show drun") end)

local bg
function gSwap(mode)
	if (mode == "on") then
		bg = mylauncher.bg 
		mylauncher.bg = beautiful.bg_focus	
	else
		mylauncher.bg = bg
	end
end

mylauncher:connect_signal("mouse::enter", function() gSwap("on") end)
mylauncher:connect_signal("mouse::leave", function() gSwap() end)




--local bg
--function bgSwap(mode)
--	if (mode == "on") then
--		bg = menubutton.bg 
--		menubutton.bg = "#FF0000"	
--	else
--		menubutton.bg = bg
--	end
--end
--
--menuicon = wibox.widget.imagebox()
--menuicon:set_image(beautiful.launcher_icon)
--menubutton = wibox.container.background(menuicon, "#00FF00")
--
--menubutton:connect_signal("mouse::enter", function() bgSwap("on") end)
--menubutton:connect_signal("mouse::leave", function() bgSwap() end)
--
--mylauncher = menubutton









--local bg
--function bgSwap(mode, widget)
--	if (mode == "on") then
--		bg = widget.bg 
--		widget.bg = "#44444444"	
--	else
--		widget.bg = bg
--	end
--end

--mylauncher:connect_signal("mouse::enter", function() bgSwap("on", mylauncher) end)
--mylauncher:connect_signal("mouse::leave", function() bgSwap("off", mylauncher) end)



