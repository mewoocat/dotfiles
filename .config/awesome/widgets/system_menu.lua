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
local tray = require("widgets/tray")
local night_light = require("widgets/night_light")
local wifi = require("widgets/wifi")
local theme_mode = require("widgets/theme_mode")
local power = require("widgets/power")


local system_menu = {}



local menu = awful.popup {
    widget = {	
        {
			{	
				{
					{
						{
							{
								--forced_width = 60,
								forced_height = 50,
								--resize = false,
								widget = audio.icon,
							},
							widget = wibox.container.margin,
							margins = 10,
						},
						{
							widget = audio.slider,
						},
						layout = wibox.layout.fixed.horizontal,
					},
					{
						{
							{
								--forced_width = 60,
								forced_height = 50,
								--resize = false,
								widget = brightness.icon,
							},
							widget = wibox.container.margin,
							margins = 10,
						},
						{
							widget = brightness.slider,
						},
						layout = wibox.layout.fixed.horizontal,
					},
					layout = wibox.layout.fixed.vertical,
				},
				widget = wibox.container.margin,
				margins = 4,
			},
			{
					{
						{	
							{
								{
									widget = moniter.cpu_temp,
								},
								{
									widget = moniter.cpu_temp_int,
								},
								layout = wibox.layout.stack,
							},
							{
								widget = moniter.cpu_usage,  
							},
							{
								widget = moniter.cpu_usage_percent,
							},
							{
								widget = moniter.mem_usage,
							},
							{
								widget = moniter.mem_usage_percent,
							},
		
							
							spacing = 20,
							layout = wibox.layout.fixed.horizontal,
						},
						widget = wibox.container.margin,
						margins = 16,
					},
					bg     = beautiful.bg_alt,
                	clip   = true,
                	shape  = gears.shape.rounded_rect,
                	widget = wibox.container.background

			},
			{
					{
						forced_height = 100,
						forced_width = 100,
						widget = wifi.ssid,
					},
					{
						forced_height = 100,
						forced_width = 100,
            		    widget = theme_mode.button,
						-- add ssid
            		},
					{	
						forced_height = 100,
						forced_width = 100,
						widget = night_light.button,
					},
					{	
						forced_height = 100,
						forced_width = 100,
						widget = wifi.button,
					},

					--forced_height = 600,
					--forced_width = 600,

					forced_num_cols = 4,
   					forced_num_rows = 1,
					--forced_height = 400,
					--forced_width = 400,
					--spacing = 40,
					--horizontal_homogeneous = true,
					--vertical_homogeneous = true,	
   					homogeneous     = true,
   					--expand          = true,		
					layout = wibox.layout.grid,
			},
			{
                {
					
					{
						{
							widget = user.pfp,
						},
						widget = wibox.container.margin,
						margins = 16,
					},
					{
                    	widget = user.name,
					},
					{
						widget = power.power_button,
					},	
					layout = wibox.layout.align.horizontal,
					--fill_space = true,
					expand = "none",

                },
                bg     = beautiful.bg_alt,
                clip   = true,
                shape  = gears.shape.rounded_rect,
                widget = wibox.container.background
            },


			--[[
			{
				widget = tray.systray
			},
			--]]
			
			
				

				
			--forced_num_cols = 2,
    		--forced_num_rows = 2,
    		--homogeneous     = true,
    		--expand          = true,
    		--layout = wibox.layout.grid
            layout = wibox.layout.fixed.vertical,
			spacing = 20,
        },
        margins = 50,
		--forced_height = 1000,
        --forced_width  = 680,

        widget  = wibox.container.margin,
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
	maximum_width		 = 500,
	maximum_height		 = 800,
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
		bg = system_menu.button.bg 
		system_menu.button.bg = beautiful.bg_focus	
	else
		system_menu.button.bg = bg
	end
end

menuicon = wibox.widget.imagebox()
menuicon:set_image(beautiful.bars)
button = wibox.container.margin(menuicon, 9, 9, 9, 9)
system_menu.button = wibox.container.background(button, "#00000000")

system_menu.button:connect_signal("mouse::enter", function() bgSwap("on") end)
system_menu.button:connect_signal("mouse::leave", function() bgSwap() end)
system_menu.button:connect_signal("button::press", function() system_menu.toggleMenu() end)





return system_menu
