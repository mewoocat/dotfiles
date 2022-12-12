

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- path to image
pfp = "/home/ghost/Pictures/zero.jpeg"

local user = {}

user.theme = "dark"

return user
