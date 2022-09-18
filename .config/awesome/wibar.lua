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

local launcher = require("widgets/launcher")

--beautiful.useless_gap = 0


awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", "5" }, s, awful.layout.layouts[1])


  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox = wibox.container.margin(
    s.mylayoutbox,
    6, 6, 6, 6
  )
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)))
  -- Create a taglist widget

  s.mytaglist = awful.widget.taglist {
    screen          = s,
    filter          = awful.widget.taglist.filter.all,
    layout          = {
      spacing = 0,
      layout  = wibox.layout.fixed.horizontal
    },
    buttons         = {
      awful.button({}, 1, function(t) t:view_only() end),
      awful.button({ modkey }, 1, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({ modkey }, 3, function(t)
        if client.focus then
          client.focus:toggle_tag(t)
        end
      end),
      --awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
      --awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
    },
    widget_template = {
      {
        {
          {
            {
              id      = "index_role",
              opacity = 0,
              widget  = wibox.widget.textbox,
            },
            bg           = "#00ffff00",
            shape        = gears.shape.circle,
            border_width = 2,
            border_color = beautiful.fg_normal,
            widget       = wibox.container.background,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left   = 8,
        right  = 8,
        --top    = 8,
        --bottom = 8
		--margins = 0,
        widget = wibox.container.margin,
      },
      --id     = "background_role",
      widget = wibox.container.background,
      bg = "ffff00",
      create_callback = function(self, c3, index, objects) --luacheck: no unused args
        self:get_children_by_id("index_role")[1].markup = "<b> " .. c3.index .. " </b>"
        local circle = self.children[1].children[1].children[1]

        self:connect_signal("mouse::enter", function()
          if circle.bg ~= "#00000000" then
            circle.backup     = circle.bg
            circle.has_backup = true
          end
          circle.bg = "#00ff00"
        end)
		self:connect_signal("mouse::leave", function()
          if circle.has_backup then circle.bg = circle.backup end
			-- causes tag not filling issue | make hover not work on selected?
        end)
        if c3.selected then
          circle.bg = beautiful.bg_focus
        end
        if c3.selected == false then
          circle.bg = "#00000000"
        end

      end,
      update_callback = function(self, c3, index, objects) --luacheck: no unused args
        self:get_children_by_id("index_role")[1].markup = "<b> " .. c3.index .. " </b>"
        local circle = self.children[1].children[1].children[1]

		self:connect_signal("mouse::enter", function()
          if circle.bg ~= "#00000000" then
            circle.backup     = circle.bg
            circle.has_backup = true
          end
          circle.bg = "#00ff00"
        end)
		self:connect_signal("mouse::leave", function()
          --if circle.has_backup then circle.bg = circle.backup end
			-- causes tag not filling issue
			circle.bg = "#00000000"
        end)

        if c3.selected then
          circle.bg = beautiful.bg_focus
		  
        end
        if c3.selected == false then
          circle.bg = "#00000000"
        end
      end,
    },
  }
  
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

s.mytasklist = awful.widget.tasklist {
    screen   = s,
    filter   = awful.widget.tasklist.filter.currenttags,
    buttons  = tasklist_buttons,
    layout   = {
        spacing_widget = {
            {
                forced_width  = 5,
                forced_height = 24,
                thickness     = 1,
                color         = "#777777",
                widget        = wibox.widget.separator
            },
            valign = "center",
            halign = "center",
            widget = wibox.container.place,
        },
        spacing = 1,
        layout  = wibox.layout.fixed.horizontal
    },
    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
        {
            wibox.widget.base.make_widget(),
            forced_height = 5,
            id            = "background_role",
            widget        = wibox.container.background,
        },
        {
            awful.widget.clienticon,
            left = 18,
			top = 4,
			bottom = 4,
			right = 18,
            widget  = wibox.container.margin
        },
        nil,
        layout = wibox.layout.align.vertical,
    },
}

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s, height = 44 })

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
  rw:connect_signal("button::press", function() system_menu.toggleMenu() end)
  --system_menu.button:connect_signal("button::press", function() system_menu.toggleMenu() end)
  local widgets = {
    {
      --tray.button,
      wibox.widget.textbox('    '),
      wifi.icon,
      wibox.widget.textbox('    '),
      battery.percent,
      battery.icon,
      wibox.widget.textbox('    '),
      audio.level,
      audio.icon,
      wibox.widget.textbox('    '),
      layout = wibox.layout.fixed.horizontal,
    },
    widget = rw
  }

  local r_widgets = {
    tray.systray,
    wibox.widget.textbox('    '),
    s.mylayoutbox,
    widgets,
    system_menu.button,
    layout = wibox.layout.fixed.horizontal,

  }

  --r_widgets:connect_signal("mouse::leave", function() bgSwap() end)

  -- Add widgets to the wibox
  s.mywibox:setup {
    expand = "none",
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      --spacing = 20,
      launcher.mylauncher,
      s.mytaglist,
      s.mypromptbox,
      s.mytasklist,
    },
    clock.textclock,
    r_widgets
  }
end)


