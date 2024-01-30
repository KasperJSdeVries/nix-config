#!/usr/bin/env bash

dir="$HOME/.config/polybar"

# Terminate already running bar instances
killall -r polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar -q main -c "$dir/config.ini" &
