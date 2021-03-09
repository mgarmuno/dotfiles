#!/bin/bash

#blueman-applet
setxkbmap -layout us -variant altgr-intl -option nodeadkeys &
#sh $HOME/.config/mtools/cliplistner.sh &
xset -dpms s off &
#xrdb -merge ~/.Xresources
blueman-applet &
pasystray &
pulseaudio &
#dwmblocks &
slstatus &
flameshot &
feh --bg-scale /home/magneto/.config/walls/welcome_home_dracula.png &
