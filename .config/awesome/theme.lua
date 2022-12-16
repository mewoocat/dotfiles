---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local gears = require("gears")

local theme = {}


-- Icon directory
local icon_dir = os.getenv("HOME") .. "/.config/awesome/icons/"

theme.systray_icon_spacing = 12

x = xresources.get_current_theme ()

theme.font          = "Roboto 12"

theme.bg_normal     = x.color0 .. "aa"
theme.bg_titlebar_normal     = x.color0 .. ""

theme.green = "#00ff00"
theme.red = "#ff0000"


theme.bg_focus      = x.color1
theme.bg_urgent     = x.color5
theme.bg_minimize   = x.color3
theme.bg_systray    = theme.bg_normal
theme.bg_alt        = x.color0 .. "99"

theme.fg_normal     = x.color7
theme.fg_focus      = theme.bg_normal
theme.fg_urgent     = x.color1
theme.fg_minimize   = x.color4

theme.dock_bg       = x.color0 .. "55"

theme.useless_gap   = dpi(8)
theme.border_width  = dpi(0)
theme.border_normal = theme.bg_normal
theme.border_focus  = x.color6
theme.border_marked = x.color5

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
--theme.titlebar_close_button_normal = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_close_button_normal = icon_dir.."circle.png"

theme.titlebar_close_button_focus  = icon_dir.."circle.png"

theme.titlebar_minimize_button_normal = icon_dir.."circle2.png"
theme.titlebar_minimize_button_focus  = icon_dir.."circle2.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = icon_dir.."circle3.png"
theme.titlebar_maximized_button_focus_inactive  = icon_dir.."circle3.png"
theme.titlebar_maximized_button_normal_active = icon_dir.."circle2.png"
theme.titlebar_maximized_button_focus_active  = icon_dir.."circle2.png"

--theme.wallpaper = themes_path.."default/background.png"
--theme.wallpaper = "~/wallpapers/0307.jpg"
--theme.wallpaper = io.popen("cat /home/ghost/.cache/wal/wal")
local wal = io.open("/home/ghost/.cache/wal/wal")
theme.wallpaper = wal:read()
wal:close()


-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"

theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_floating  = gears.color.recolor_image(theme.layout_floating,
theme.fg_normal )

theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"

theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tile = gears.color.recolor_image(theme.layout_tile,
theme.fg_normal)

theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)



-- Custom Icons:
theme.launcher_icon = "/home/ghost/.config/awesome/icons/gundam.svg"
theme.launcher_icon = gears.color.recolor_image(theme.launcher_icon, theme.fg_urgent )

-- Battery icons
theme.battery_icon = icon_dir .. "bat-full.svg"
theme.battery_icon = gears.color.recolor_image(theme.battery_icon, theme.fg_normal )

theme.battery_empty = icon_dir .. "battery_empty.svg"
theme.battery_empty = gears.color.recolor_image(theme.battery_empty, theme.fg_normal )

theme.battery_full = icon_dir .. "battery_full.svg"
theme.battery_full = gears.color.recolor_image(theme.battery_full, theme.green )

theme.battery_75 = icon_dir .. "battery_75.svg"
theme.battery_75 = gears.color.recolor_image(theme.battery_75, theme.green )

theme.battery_50 = icon_dir .. "battery_50.svg"
theme.battery_50 = gears.color.recolor_image(theme.battery_50, theme.green )

theme.battery_25 = icon_dir .. "battery_25.svg"
theme.battery_25 = gears.color.recolor_image(theme.battery_25, theme.red )

theme.battery_charging_frame = icon_dir .. "battery_charging_frame.svg"
theme.battery_charging_frame = gears.color.recolor_image(theme.battery_charging_frame, theme.fg_normal )

theme.battery_charging_amount = icon_dir .. "battery_charging_amount.svg"
theme.battery_charging_amount = gears.color.recolor_image(theme.battery_charging_amount, theme.green )


-- Volume icons
theme.vol_high = icon_dir .. "vol.svg"
theme.vol_high = gears.color.recolor_image(theme.vol_high, theme.fg_normal )

theme.volume_3 = icon_dir .. "volume_3.svg"
theme.volume_3 = gears.color.recolor_image(theme.volume_3, theme.fg_normal)

theme.volume_2 = icon_dir .. "volume_2.svg"
theme.volume_2 = gears.color.recolor_image(theme.volume_2, theme.fg_normal)

theme.volume_1 = icon_dir .. "volume_1.svg"
theme.volume_1 = gears.color.recolor_image(theme.volume_1, theme.fg_normal)

theme.volume_0 = icon_dir .. "volume_0.svg"
theme.volume_0 = gears.color.recolor_image(theme.volume_0, theme.fg_normal)

theme.volume_mute = icon_dir .. "volume_mute.svg"
theme.volume_mute = gears.color.recolor_image(theme.volume_mute, theme.fg_normal)

-- wifi icons
theme.wifi_3 = icon_dir .. "wifi-3.svg"
theme.wifi_3 = gears.color.recolor_image(theme.wifi_3, theme.fg_normal)

theme.wifi_2 = icon_dir .. "wifi-2.svg"
theme.wifi_2 = gears.color.recolor_image(theme.wifi_2, theme.fg_normal)

theme.wifi_1 = icon_dir .. "wifi-1.svg"
theme.wifi_1 = gears.color.recolor_image(theme.wifi_1, theme.fg_normal)

theme.wifi_0 = icon_dir .. "wifi-0.svg"
theme.wifi_0 = gears.color.recolor_image(theme.wifi_0, theme.fg_normal)

theme.wifi_dc = icon_dir .. "wifi-dc.svg"
theme.wifi_dc = gears.color.recolor_image(theme.wifi_dc, theme.fg_normal)




theme.bat_charging = gears.color.recolor_image(icon_dir .. "battery_c.svg", theme.fg_normal)

theme.menu_icon = icon_dir .. "razer.svg"
theme.menu_icon = gears.color.recolor_image(theme.menu_icon, theme.fg_normal)

theme.circle = icon_dir .. "circle.svg"
theme.circle = gears.color.recolor_image(theme.circle, theme.fg_normal)

theme.bars = icon_dir .. "bars.svg"
theme.bars = gears.color.recolor_image(theme.bars, theme.fg_normal)

theme.moon = icon_dir .. "moon.svg"
theme.moon = gears.color.recolor_image(theme.moon, theme.fg_normal)

theme.brightness = icon_dir .. "brightness.svg"
theme.brightness = gears.color.recolor_image(theme.brightness, theme.fg_normal)


theme.power = icon_dir .. "power.svg"
theme.power = gears.color.recolor_image(theme.power, theme.fg_normal)

theme.cpu_icon = icon_dir .. "cpu.svg"
theme.cpu_icon = gears.color.recolor_image(theme.cpu_icon, theme.fg_normal)

theme.mem_icon = icon_dir .. "mem.svg"
theme.mem_icon = gears.color.recolor_image(theme.mem_icon, theme.fg_normal)

theme.triangle_icon = icon_dir .. "triangle.svg"
theme.triangle_icon = gears.color.recolor_image(theme.triangle_icon, theme.fg_normal)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
--theme.icon_theme = nil
theme.icon_theme = "Papirus"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
