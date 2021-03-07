#!/bin/bash

#blueman-applet
setxkbmap -layout us -variant altgr-intl -option nodeadkeys &
#$HOME/.config/mtools/ttyecho -n /dev/pts/0 sh $HOME/.config/mtools/cliplistner.sh &
xset -dpms s off &
#xrdb -merge ~/.Xresources
blueman-applet &
pasystray &
pulseaudio &
#dwmblocks &
slstatus &
feh --bg-scale /home/magneto/.config/walls/welcome_home_dracula.png &
