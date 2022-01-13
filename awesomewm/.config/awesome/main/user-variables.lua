local home = os.getenv("HOME")

local _M = {
    modkey = "Mod4",
    editor = os.getenv("EDITOR") or "vim",
    terminal = "alacritty"
}

return _M