local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local tag = {}

function tag.getTaglist(s)
    mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = {
        spacing = 0,
        layout  = wibox.layout.fixed.horizontal
        },
        buttons = {
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
            circle.bg = beautiful.fg_normal
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
            circle.bg = beautiful.fg_normal
            end)
            self:connect_signal("mouse::leave", function()
            --if circle.has_backup then circle.bg = circle.backup end
                -- causes tag not filling issue
                if c3.selected == false then
                    circle.bg = "#00000000"	
                end
            end)

            if c3.selected then
            circle.bg = beautiful.fg_normal
            
            end
            if c3.selected == false then
            circle.bg = "#00000000"
            end
        end,
        },
    }
    return mytaglist
end

return tag