local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")

-- widgets
local brightness = require("widgets.brightness")
local audio = require("widgets.audio")
local moniter = require("widgets/moniter")
local user = require("widgets/user")

local system_menu = {}



menu = awful.popup {
    widget = {	
        {
			{
				widget = user.name,
			},
			{
				widget = audio.slider,
			},
			{
				widget = brightness.slider,
			},
			{
					{
						widget = wifi.ssid,
					},
					{
            		    widget = wifi.status,
						-- add ssid
            		},
					{
						widget = moniter.cpu_temp
					},
					{
            		    widget = wifi.ssid,
						-- add ssid
            		},
					forced_num_cols = 2,
   					forced_num_rows = 2,
   					homogeneous     = true,
   					expand          = true,		
					layout = wibox.layout.grid,
			},
			{
                {
                    text   = 'foobar',
                    widget = wibox.widget.textbox
                },
                bg     = '#00ff00',
                clip   = true,
                shape  = gears.shape.rounded_bar,
                widget = wibox.container.background
            }, 	
		
			forced_num_cols = 2,
    		forced_num_rows = 2,
    		--homogeneous     = true,
    		--expand          = true,
    		--layout = wibox.layout.grid
            layout = wibox.layout.fixed.vertical,
			spacing = 10,
        },
        margins = 50,
		forced_height = 1000,
        forced_width  = 1000,

        widget  = wibox.container.margin
    },
    border_color = '#00ff00',
    border_width = 0,
	-- https://www.reddit.com/r/awesomewm/comments/m0fya9/ruled_placement_offset/gq9b5lv/
    placement    = function(c)
						return awful.placement.top_right(c, {honor_workarea=true, margins=20})
					end,
    shape        = gears.shape.rounded_rect,
    visible      = false,
	ontop		 = true,
	--opacity		 = 1.0,
	--bg			 = "#ffffff",	
	maximum_width		 = 800,
	maximum_height		 = 1200,
}



function system_menu.toggleMenu() 
	if (menu.visible == true)
	then 
		menu.visible = false
	else 
		menu.visible = true
	end
end


local bg
function bgSwap(mode)
	if (mode == "on") then
		bg = menu.bg 
		menu.bg = beautiful.bg_focus	
	else
		menu.bg = bg
	end
end

--menuicon = wibox.widget.imagebox()
--menuicon:set_image(beautiful.bars)
--menu = wibox.container.margin(menuicon, 9, 9, 9, 9)
--menu = wibox.container.background(menu, "#00000000")

--menu:connect_signal("mouse::enter", function() bgSwap("on") end)
--menu:connect_signal("mouse::leave", function() bgSwap() end)
--menu:connect_signal("button::press", function() toggleMenu(system_menu)  end)





return system_menu
