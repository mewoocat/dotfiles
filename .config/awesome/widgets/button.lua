local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")

local button = {}


local bg
function button:hoverOn(b)
	bg = b.bg
	b.bg = beautiful.bg_focus
end

function button:hoverOff(b)
	b.bg = bg
end



return button
