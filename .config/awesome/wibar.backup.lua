local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

require("dock")

-- clock
local clock = require("widgets/clock")

-- battery
local battery = require("widgets/battery")

-- wifi
local wifi = require("widgets/wifi")

-- tray 
local tray = require("widgets/tray")

-- audio
local audio = require("widgets/audio")

-- Launcher
local launcher = require("widgets/launcher")

-- System menu
local system_menu = require("widgets/system_menu")


--beautiful.useless_gap = 0


awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", "5", "6", "7", "8" }, s, awful.layout.layouts[1])

 	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()

	-- Create a layout button
	s.mylayoutbox = require("widgets/layout")

	-- Create a taglist widget
	--s.mytaglist = require("widgets/taglist")
	tag = require("widgets/taglist")
	s.mytaglist = tag.getTaglist(s)

	-- Tasklist
	task = require("widgets/tasklist")
	s.mytasklist = task.getTasklist(s)


  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s, height = 44 })


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
      tray.systray,
      tray.button,
      wibox.widget.textbox('    '),
      s.mylayoutbox,
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
      --s.mytasklist,
    },
    clock.textclock,
    r_widgets
  }
end)


