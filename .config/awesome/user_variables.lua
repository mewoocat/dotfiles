

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- path to image
pfp = "/home/ghost/Pictures/cat-black.gif"

local user = {}

user.theme = "dark"

return user
