local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
--local mousegrabber = require("mousegrabber")

local dock = {}

awful.screen.connect_for_each_screen(function(s)

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
--[[
    dock.dock = awful.popup {
        widget = awful.widget.tasklist {
            screen   = s,
            filter   = awful.widget.tasklist.filter.currenttags,
            buttons  = tasklist_buttons,
            style    = {
                shape = gears.shape.rounded_rect,
            },
            layout   = {
                spacing = 5,
                forced_num_rows = 1,
                layout = wibox.layout.grid.horizontal
            },
            widget_template = {
                {
                    {
                        {
                            id     = "clienticon",
                            widget = awful.widget.clienticon,
                        },
                        margins = 4,
                        widget  = wibox.container.margin,
                    },
                    id              = "background_role",
                    forced_width    = 48,
                    forced_height   = 48,
                    widget          = wibox.container.background,
                    create_callback = function(self, c, index, objects) --luacheck: no unused
                        self:get_children_by_id("clienticon")[1].client = c
                    end,
                },
                margins = 16,
                widget = wibox.container.margin
            }
        },
        border_color = "#777777",
        border_width = 0,
        ontop        = true,
        placement    = awful.placement.bottom,
        shape        = gears.shape.rounded_rect
    }
]]

    local d = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        style    = {
            shape = gears.shape.rounded_rect,
        },
        layout   = {
            spacing = 5,
            forced_num_rows = 1,
            layout = wibox.layout.grid.horizontal
        },
        widget_template = {
			{
				{
					{
						{
							id     = "clienticon",
							widget = awful.widget.clienticon,
						},
						margins = 4,
						widget  = wibox.container.margin,
					},
					--id              = "background_role",   -- does stuff for styling and rules
					forced_width    = 48,
					forced_height   = 48,
					widget          = wibox.container.background,
					create_callback = function(self, c, index, objects) --luacheck: no unused
						self:get_children_by_id("clienticon")[1].client = c
					end,
					bg = "#00000000",
				},
            	margins = 16,
            	widget = wibox.container.margin
			},
			widget= wibox.container.background,
			bg = "#00000000",
        }
    }

    dockThing = awful.wibar({ position = "bottom", screen = s, height = 80, width = 800, stretch = false, opacity =0, })
    --dockThing.input_passthrough = true
    --dockThing.ontop = false
    ghostDock = awful.popup {
        widget = d,
		--widget = wibox.widget.textbox("hi"),
        visible = false,
        --minimum_width = 400,
        --minimum_height = 20,
        bg = "#ffffff",
        ontop = true,
        --y = 1360,
        --x = 780,
        opacity = 1,
        placement   = awful.placement.bottom,
        --input_passthrough = true,
    }
    ghostDock:connect_signal("mouse::enter", function()
        dockPopup.visible = false
        dockThing.visible = true
    end)
    ghostDock:connect_signal("mouse::leave", function()
        dockPopup.visible = false
        dockThing.visible = false
    end)
    dockPopup = awful.popup{
        widget = d,
        visible = true,
        ontop = true,
        type = "normal",
		bg = beautiful.dock_bg,
        placement   = awful.placement.bottom,
		--hide_on_right_click = true,	

    }
--[[
    dockPopup:connect_signal("mouse::enter", function() 
        dockPopup.visible = true
        dockThing.visible = true
        -- object_under_pointer ()
    end)

    dockPopup:connect_signal("mouse::leave", function() 
        dockPopup.visible = false
        dockThing.visible = false
    end)
    --dockThing.bg = beautiful.bg_normal
]]
--[[
    dockThing:connect_signal("mouse::enter", function()
        dockThing.visible = true
     end)
     dockThing:connect_signal("mouse::leave", function()
        dockThing.visible = false
     end)
]]
--[[
     mousegrabber.run(function(mouse) 
        if mouse.y == 0 then
            dockThing.visible = true
        else   
            dockThing.visible = false
        end
        return true
     end)
]]
--[[
    dockThing:setup {
        expand = "none",
        layout = wibox.layout.align.horizontal,
        wibox.widget.textbox('    '),
        dockPopup,
        wibox.widget.textbox('    '),

      }
]]
end)

return dock
