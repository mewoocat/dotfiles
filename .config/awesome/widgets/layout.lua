local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")


local s = {}

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

return s.mylayoutbox