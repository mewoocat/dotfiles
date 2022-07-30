local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")

-- widgets
require("widgets.brightness")

local system_menu = {}


local vol_slider = wibox.widget {
	bar_shape = gears.shape.rounded_rect,
	bar_height          = 10,
	bar_color           = beautiful.fg_focus,
	handle_color        = beautiful.bg_focus,
	handle_shape        = gears.shape.circle,
	handle_border_color = beautiful.border_color,
	handle_border_width = 8,
	handle_width 		= 40,
	value               = 0,
	forced_height		= 20,
	forced_width		= 60,
	widget              = wibox.widget.slider,
}

-- sets volume slider value on start
awful.spawn.easy_async("pamixer --get-volume", function(stdout)
	vol_slider["value"] = tonumber(stdout)
end)

-- Connect to `property::value` to use the value on change
vol_slider:connect_signal("property::value", function(_, new_value)
    --naughty.notify { title = "Slider changed", message = tostring(new_value) }
	awful.spawn.with_shell("pamixer --set-volume " .. tostring(new_value))	
end)




menu = awful.popup {
    widget = {	
        {
            {
                widget = wifi_status,
				-- add ssid
            },
			{
				widget = vol_slider,
			},
			{
				widget = brightness_slider,
			},
			{
				widget = awful.widget.watch('bash -c "sensors | grep Package | cut -d \' \' -f 5 | cut -c 2-"', 1)
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
			spacing = 50,
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
	maximum_height		 = 600,
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
