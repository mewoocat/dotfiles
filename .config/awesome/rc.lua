-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

require("error_handling")

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

require("startup")

beautiful.init("~/.config/awesome/theme.lua")

require("awful.hotkeys_popup.keys")


--require("error_handling")
require("user_variables")
require("layouts")
require("widgets/launcher")
require("wallpaper")
-- SOMETHING IS WRONG WITH THE WIBAR WHICH CAUSES ERROR HANDLING NOT TO WORK???????
-- maybe from breaking wibar up into more files
require("wibar")
require("dock")
require("keybinds")
require("rules")
require("signals")

--require("startup")


