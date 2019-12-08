#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bars
#MONITOR="HDMI-0" polybar -c ~/.config/i3/polybar/config bar-hdmi -r &
#MONITOR="DP-1-2" polybar -c ~/.config/i3/polybar/config bar-dvi -r &
#MONITOR="DVI-D-0" polybar -c ~/.config/i3/polybar/config bar-dp -r &
#MONITOR="eDP-1" polybar main_bar -r &
polybar -c ~/.config/i3/polybar/config bar-hdmi -r &
polybar -c ~/.config/i3/polybar/config bar-dp -r &
polybar -c ~/.config/i3/polybar/config bar-dvi -r &

echo "Bars launched..."
