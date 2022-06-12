-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")

local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

beautiful.init("~/.config/awesome/theme.lua")

require("awful.hotkeys_popup.keys")
require("error_handling")
require("user_variables")
require("layouts")
require("widgets/launcher")


-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it


-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()
mytextclock.format = "%l:%M %p"

--systray widget
mysystray = wibox.widget.systray()
mysystray = wibox.container.margin(wibox.widget.systray(), 9, 9, 9, 9)
--mysystray:set_base_size(10)


vol_image = wibox.widget.imagebox()
vol_image:set_image(beautiful.vol_high)
vol_icon = wibox.container.margin(
	vol_image,
	9, 9, 9, 9
)

audio = wibox.widget.textbox()
awful.spawn.easy_async("pamixer --get-volume", function(stdout)
	audio.text = stdout:sub(0, -2) .. "%"
end)
myaudio = wibox.container.margin(
	--awful.widget.watch('pamixer --get-volume', 1),
	audio,
	2, 2, 2, 2
)

-- battery
require("widgets/battery")

-- wifi
require("widgets/wifi")


require("widgets/popupmenu")

-- Create a wibox for each screen and add ir
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                     {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
	awful.tag({"Home", " o ", " o ", " o ", " o "  }, s, awful.layout.layouts[1])

--awful.tag.add("", {
--	icon               = beautiful.menu_icon,
--	layout             = awful.layout.suit.tile,
--	master_fill_policy = "master_width_factor",
--	gap_single_client  = true,
--    gap                = 20,
--    screen             = s,
--    selected           = true,
--})
--
--awful.tag.add("2", {
--	icon               = "/path/to/icon1.png",
--	layout             = awful.layout.suit.tile,
--	master_fill_policy = "master_width_factor",
--	gap_single_client  = true,
--    gap                = 10,
--    screen             = s,
--    selected           = true,
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
        filter  = awful.widget.taglist.filter.all,
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
		mytextclock,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            --mykeyboardlayout,
            mysystray,
			menubutton,
			--wifi_status,
			wifi,
            wibox.widget.textbox(' '),
			battery,
			battery_icon,
			wibox.widget.textbox(' '),
			myaudio,
			vol_icon,
			wibox.widget.textbox(' '),
            s.mylayoutbox,
        },
    }
end)
-- }}}

require("keybinds")
require("rules")
require("signals")




