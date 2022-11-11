#!/bin/bash

#blueman-applet
setxkbmap -layout us -variant altgr-intl -option nodeadkeys &
#sh $HOME/.config/mtools/cliplistner.sh &
xset -dpms s off &
#xrdb -merge ~/.Xresources
blueman-applet &
pasystray &
#pulseaudio &
dwmblocks &
#slstatus &
flameshot &
insync start &
feh --bg-scale /home/magneto/.config/walls/3440x1440/cowboy_bebop.jpg &
