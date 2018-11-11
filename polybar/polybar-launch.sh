#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 0.5; done

# Launch top and bottom bars
polybar top 2>&1 &
polybar bottom 2>&1 &

echo "launched polybar"

# Hot corners
xdotool behave_screen_edge --delay 500 --quiesce 1000 top-left key ctrl+shift+w &
xdotool behave_screen_edge --delay 500 --quiesce 1000 top-right key ctrl+shift+c &
