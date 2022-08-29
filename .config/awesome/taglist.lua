local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local t = {}

t.taglist = awful.widget.taglist {
  		screen  = s,
  		filter  = awful.widget.taglist.filter.all,
  		layout   = {
  		    spacing = 0,
  		    layout  = wibox.layout.fixed.horizontal
  		},
		buttons = {
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
          awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
          awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
      	},
  		
    		widget_template = {
    		    {
						{
							{
								{
									id     = "index_role",
									opacity = 0,
									widget = wibox.widget.textbox,
								},
								bg     = "#00ffff00",
								shape  = gears.shape.circle,
								border_width = 2,
								border_color = beautiful.fg_normal,
								widget = wibox.container.background,
							},
							layout = wibox.layout.fixed.horizontal,
						},
						left  = 10,
						right = 10,
						top   = 10,
						bottom = 10,
						widget = wibox.container.margin,
					},
					--id     = "background_role",
					widget = wibox.container.background,
					bg = "ffff00",
					shape  = gears.shape.circle,
					create_callback = function(self, c3, index, objects) --luacheck: no unused args
						self:get_children_by_id("index_role")[1].markup = "<b> "..c3.index.." </b>"
						self:connect_signal("mouse::enter", function()
							if self.bg ~= "#000000" then
								self.backup     = self.bg
								self.has_backup = true
							end
							self.bg = "#00ff00"
						end)
						self:connect_signal("mouse::leave", function()
							if self.has_backup then self.bg = self.backup end
						end)
						if c3.selected then
							self.bg = "#ff0000"
						end
						if c3.selected == false then
							self.bg = "#00000000"
						end
					end,
					update_callback = function(self, c3, index, objects) --luacheck: no unused args
						self:get_children_by_id("index_role")[1].markup = "<b> "..c3.index.." </b>"
						if c3.selected then
							self.bg = "#00ff00"
						end
						if c3.selected == false then
							self.bg = "#00000000"
						end
					end,
			},

}


return t
