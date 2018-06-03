#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 0.5; done

# Launch top and bottom bars
polybar top 2>&1 &
polybar bottom 2>&1 &

echo "launched polybar"
