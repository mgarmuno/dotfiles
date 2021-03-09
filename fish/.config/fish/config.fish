starship init fish | source

set -x GOPATH ~/go

if status is-interactive
	sh $HOME/.config/mtools/cliplistner.sh>/dev/null &
	neofetch
end

# start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx
    end
end

