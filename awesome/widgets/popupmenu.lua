local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")






menu = awful.popup {
    widget = {	
        {
            {
                widget = wifi_status,
				-- add ssid
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
                forced_height = 400,
                forced_width  = 800,
                widget        = wibox.widget.calendar.month(os.date('*t'))
            },
			wibox.widget {
    			{
        			max_value     = 1,
        			value         = 0.5,
        			forced_height = 20,
        			forced_width  = 100,
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
				forced_num_cols = 2,
    			forced_num_rows = 2,
    			homogeneous     = true,
    			expand          = true,
    			layout = wibox.layout.grid
			},
            layout = wibox.layout.fixed.vertical,
        },
        margins = 30,
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
	ontop		 = true
}

menubutton = wibox.widget.imagebox()
menubutton:set_image(beautiful.launcher_icon)
function toggleMenu() 
	if (menu.visible == true)
	then 
		menu.visible = false
	else 
		menu.visible = true
	end
end
menubutton:connect_signal("button::press", function() toggleMenu()  end)
