local wibox = require("wibox")
local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

audio = {}

-- volume icon
local audio_image = wibox.widget.imagebox()
audio.icon = wibox.container.margin(
	audio_image,
	6, 6, 6, 6
)

-- volume percentage
local level_text = wibox.widget.textbox()
--audio.level_text:set_text("what")
--[[
awful.spawn.easy_async("pamixer --get-volume", function(stdout, stderr, exitreason, exitcode)
	audio.level_text:set_text(stdout:sub(0, -2) .. "%")
	naughty.notify({ preset = naughty.config.presets.critical, title = "Debug",text = tostring(stdout) })
	naughty.notify({ preset = naughty.config.presets.critical, title = "Debug",text = tostring(exitcode) })
	--audio.level_text:set_text(stdout)
	audio.level_text.text = "what"
end)
]]

local isMute = false

function audio.init()
	awful.spawn.easy_async("pamixer --get-volume", function(stdout)
		level_text:set_text(stdout:sub(0, -2) .. "%")
	end)		
	audio_image:set_image(beautiful.volume_3)
	awful.spawn.easy_async("pamixer --get-mute", function(stdout)
	
		if stdout == "false" then
			isMute = false
		else
			isMute = true
			audio_image:set_image(beautiful.volume_mute)
		end
	end)
end
audio.init()


--naughty.notify({ preset = naughty.config.presets.critical, title = "Debug",text = tostring(output) })

audio.level = wibox.container.margin(
	--awful.widget.watch('pamixer --get-volume', 1),
	level_text,
	2, 2, 2, 2
)



function audio.setIcon(name)
	audio_image:set_image(name)
end

audio.setIcon(beautiful.vol_high)

local function update_audio()
	-- Update level text
	-- Update slider
	-- Update Icon
end

function audio.up()
	awful.spawn.with_shell("pamixer -i 5")
	awful.spawn.easy_async("pamixer --get-volume", function(stdout)
		audio.slider["value"] = tonumber(stdout)
		level_text.text = stdout:sub(0, -2) .. "%"
	end)
end


function audio.down()
	awful.spawn.with_shell("pamixer -d 5") 
	awful.spawn.easy_async("pamixer --get-volume", function(stdout)
		audio.slider["value"] = tonumber(stdout)
		level_text.text = stdout:sub(0, -2) .. "%"
	end)
end

function audio.mute()
	awful.spawn.with_shell("pamixer -t")
	
	awful.spawn.easy_async("pamixer --get-mute", function(stdout)
		--naughty.notify({ preset = naughty.config.presets.critical, title = "Debug",text = tostring(stdout) .. "hi" })
		if tostring(stdout) == "false\n" then
			isMute = false
			audio_image:set_image(beautiful.volume_3)
		elseif tostring(stdout) == "true\n" then
			isMute = true
			audio_image:set_image(beautiful.volume_mute)
		end
	end)
end


-- volume slider widget
audio.slider = wibox.widget {
	bar_shape = gears.shape.rounded_rect,
	bar_height          = 10,
	bar_color           = beautiful.fg_normal,
	handle_color        = beautiful.bg_focus,
	handle_shape        = gears.shape.circle,
	handle_border_color = beautiful.border_color,
	handle_border_width = 0,
	handle_width		= 40,
	handle_margins		= 0,
	value               = 25,
	forced_height		= 60,
	minimum = 0,
	maximum = 100,
	--forced_width		= 60,
	widget              = wibox.widget.slider,
}

-- sets volume slider value on start
awful.spawn.easy_async("pamixer --get-volume", function(stdout)
	audio.slider["value"] = tonumber(stdout)
end)


-- Connect to `property::value` to use the value on change
audio.slider:connect_signal("property::value", function(_, new_value)
    --naughty.notify { title = "Slider changed", message = tostring(new_value) }
	awful.spawn.with_shell("pamixer --set-volume " .. tostring(new_value))	
	--audio.test_text.text = "whattt"
	--audio.setIcon(beautiful.moon)
	if new_value > 50 then
		audio.setIcon(beautiful.volume_3)
	else
		audio.setIcon(beautiful.volume_1)
	end
	
	awful.spawn.easy_async("pamixer --get-volume", function(stdout)
		--naughty.notify({ preset = naughty.config.presets.critical, title = "Debug",text = tostring(stdout) })
		level_text.text = stdout:sub(0, -2) .. "%"
	end)
	
end)


return audio
