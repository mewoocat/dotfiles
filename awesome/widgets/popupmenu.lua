local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")






system_menu = awful.popup {
    widget = {	
        {
            {
                widget = wifi_status,
				-- add ssid
            },
			{
				widget = awful.widget.watch('bash -c "sensors | grep Package | cut -d \' \' -f 5 | cut -c 2-"', 1)
			},
			{
		    	bar_shape           = gears.shape.rounded_rect,
		    	bar_height          = 3,
		    	bar_color           = "#ff0000",
		    	handle_color        = "#00ff00",
		    	handle_shape        = gears.shape.circle,
		    	handle_border_color = beautiful.border_color,
		    	handle_border_width = 1,
		    	value               = 25,
				forced_height		= 20,
				forced_width		= 60,
		    	widget              = wibox.widget.slider,
			},
            {
                {
                    text   = 'foobar',
                    widget = wibox.widget.textbox
                },
                bg     = '#00000000',
                clip   = true,
                shape  = gears.shape.rounded_bar,
                widget = wibox.widget.background
            },
            {
                value         = 0.5,
                --forced_height = 200,
                --forced_width  = 400,
                widget        = wibox.widget.calendar.month(os.date('*t'))
            },
			wibox.widget {
    			{
        			max_value     = 1,
        			value         = 0.5,
        			--forced_height = 20,
        			--forced_width  = 100,
        			paddings      = 10,
        			border_width  = 1,
        			border_color  = beautiful.border_color,
        			widget        = wibox.widget.progressbar,
    			},
    			{
        			text   = "50%",
        			valign = "center",
        			align  = "center",
        			widget = wibox.widget.textbox,
    			},

			},
			forced_num_cols = 2,
    		forced_num_rows = 2,
    		--homogeneous     = true,
    		--expand          = true,
    		--layout = wibox.layout.grid
            layout = wibox.layout.fixed.vertical,
        },
        margins = 30,
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
	
	minimum_width		 = 600,
	height		 = 200,
}


function toggleMenu(menu) 
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
		bg = menubutton.bg 
		menubutton.bg = "#44444444"	
	else
		menubutton.bg = bg
	end
end

menuicon = wibox.widget.imagebox()
menuicon:set_image(beautiful.launcher_icon)
menubutton = wibox.container.background(menuicon, "#00000000")

menubutton:connect_signal("mouse::enter", function() bgSwap("on") end)
menubutton:connect_signal("mouse::leave", function() bgSwap() end)
menubutton:connect_signal("button::press", function() toggleMenu(system_menu)  end)

calender = awful.popup {
    widget = {
        {
            {
                value         = 0.5,
                forced_height = 400,
                forced_width  = 400,
                widget        = wibox.widget.calendar.month(os.date('*t'))
            },
            layout = wibox.layout.fixed.vertical,
        },
        margins = 10,
        widget  = wibox.container.margin
    },
    border_width = 0,
	-- https://www.reddit.com/r/awesomewm/comments/m0fya9/ruled_placement_offset/gq9b5lv/
    placement    = function(c)	return awful.placement.top(c, {honor_workarea=true, margins=20})	end,
    shape        = gears.shape.rounded_rect,
    visible      = false,
	ontop		 = true,
}

mytextclock:connect_signal("button::press", function() toggleMenu(calender)  end)
