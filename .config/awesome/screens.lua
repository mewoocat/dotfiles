
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")


-- clock
local clock = require("widgets/clock")

-- battery
local battery = require("widgets/battery")

-- wifi
local wifi = require("widgets/wifi")

local tray = require("widgets/tray")
local audio = require("widgets/audio")



awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
	awful.tag({" 1 ", " 2 ", " 3 ", " 4 ", "5"  }, s, awful.layout.layouts[1])

--awful.tag.add("", {
--	icon               = beautiful.circle,
--	layout             = awful.layout.suit.tile,
--	master_fill_policy = "master_width_factor",
--	gap_single_client  = true,
--    gap                = 20,
--    screen             = s,
--    selected           = true,
--	-- source:    https://www.reddit.com/r/awesomewm/comments/mw3fn5/comment/gvjtmo4/
--	icon_only		   = true,
--})
--
--awful.tag.add("2", {
--	icon               = "/path/to/icon1.png",
--	layout             = awful.layout.suit.tile,
--	master_fill_policy = "master_width_factor",
--	gap_single_client  = true,
--    gap                = 10,
--    screen             = s,
--})
	
	

	
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        --filter  = awful.widget.taglist.filter.all,
		-- from:	https://www.reddit.com/r/awesomewm/comments/dhvq8c/hide_tags_when_not_used/
		filter = function (t) return t.selected or #t:clients() > 0 end,
		layout   = {
        	spacing = 20, 
        	layout  = wibox.layout.fixed.horizontal
    	},
        buttons = taglist_buttons,
		taglist_shape_border_width = 50,
	--	widget_template = {
	--		widget = wibox.container.margins(wibox.widget.imagebox(beautiful.circle), 20)
	--	}		
		-- from docs: https://awesomewm.org/doc/api/classes/awful.widget.taglist.html
--		widget_template = {
--        {
--            {
--                {
--                    {
--                        {
--                            id     = 'index_role',
--                            widget = wibox.widget.textbox,
--                        },
--                        margins = 4,
--                        widget  = wibox.container.margin,
--                    },
--                    bg     = '#dddddd',
--                    shape  = gears.shape.circle,
--                    widget = wibox.container.background,
--                },
--                {
--                    {
--                        id     = 'icon_role',
--                        widget = wibox.widget.imagebox,
--                    },
--                    margins = 2,
--                    widget  = wibox.container.margin,
--                },
--                {
--                    id     = 'text_role',
--                    widget = wibox.widget.textbox,
--                },
--                layout = wibox.layout.fixed.horizontal,
--            },
--            left  = 18,
--            right = 18,
--            widget = wibox.container.margin
--        },
--        id     = 'background_role',
--        widget = wibox.container.background,
--        -- Add support for hover colors and an index label
--        create_callback = function(self, c3, index, objects) --luacheck: no unused args
--            self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
--            self:connect_signal('mouse::enter', function()
--                if self.bg ~= '#ff0000' then
--                    self.backup     = self.bg
--                    self.has_backup = true
--                end
--                self.bg = '#ff0000'
--            end)
--            self:connect_signal('mouse::leave', function()
--                if self.has_backup then self.bg = self.backup end
--            end)
--        end,
--        update_callback = function(self, c3, index, objects) --luacheck: no unused args
--            self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
--        end,
--    },
    }

    -- Create a tasklist widget
   -- s.mytasklist = awful.widget.tasklist {
   --     screen  = s,
   --     filter  = awful.widget.tasklist.filter.currenttags,
   --     buttons = tasklist_buttons
  --  }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 48 })

	local system_menu = require("widgets/system_menu")
	
	local rw = wibox.widget {
		bg = "#00000000",
		widget = wibox.container.background 
	}	
	original_bg = rw.bg
	rw:connect_signal("mouse::enter", function() 
										--rw.bg = beautiful.bg_normal
										rw.bg = "#00000065" 
									  	end)
	rw:connect_signal("mouse::leave", function() rw.bg = original_bg end)
	rw:connect_signal("button::press", function() system_menu.toggleMenu()  end)	
	
	local widgets = {
		{			
			tray.button,
            tray.systray,
			wibox.widget.textbox('   '),
			wifi.icon,
            wibox.widget.textbox('   '),
			battery.percent,
			battery.icon,
			wibox.widget.textbox('   '),
			audio.level,
			audio.icon,
			wibox.widget.textbox('   '),
			layout = wibox.layout.fixed.horizontal,
		},
		widget = rw
	}

	local r_widgets = {
		s.mylayoutbox,
		widgets,
		layout = wibox.layout.fixed.horizontal,
	
	}

	--r_widgets:connect_signal("mouse::leave", function() bgSwap() end)
	
    -- Add widgets to the wibox
    s.mywibox:setup {
		expand = "none",
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
			spacing = 20,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
		clock.textclock,
  		r_widgets	
    }
end)
