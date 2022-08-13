local awful = require("awful")

awful.spawn("picom --experimental-backend")
awful.spawn("flameshot")
awful.spawn("wal -R")
awful.spawn("gammy")
