local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local clock = {}

calender = awful.popup {
    widget = {
		{
        		{
        		    {
        		        value         = 0.5,
        		        --forced_height = 400,
        		        --forced_width  = 400,
        		        widget        = wibox.widget.calendar.month(os.date('*t'))
        		    },
        		    layout = wibox.layout.fixed.vertical,
        		},
        		margins = 20,
        		widget  = wibox.container.margin,
		},
		widget = wibox.container.place,
		--halign = "center",
		forced_height = 400,
        forced_width  = 400,

    },
    border_width = 0,
	-- https://www.reddit.com/r/awesomewm/comments/m0fya9/ruled_placement_offset/gq9b5lv/
    placement    = function(c)	return awful.placement.top(c, {honor_workarea=true, margins=20})	end,
    shape        = gears.shape.rounded_rect,
    visible      = false,
	ontop		 = true,
}



function clock.toggleMenu() 
	if (calender.visible == true)
	then 
		calender.visible = false
	else 
		calender.visible = true
	end
end

clock.textclock = wibox.widget.textclock()
clock.textclock.format = "%l:%M %p"
clock.textclock.refresh = 1
clock.textclock:connect_signal("button::press", function() clock.toggleMenu()  end)


return clock
