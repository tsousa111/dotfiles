#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

screens=$(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f6)

if [[ $(hostnamectl | grep Chassis | awk '{print $2}') == "laptop" ]]; then
	if [[ $(xrandr --listactivemonitors | grep -v "Monitors" | cut -d" " -f4 | cut -d"+" -f2- | uniq | wc -l) == 1 ]]; then
		MONITOR=$(polybar --list-monitors | cut -d":" -f1) TRAY_POS=right polybar laptop &
	else
		primary=$(xrandr --query | grep primary | cut -d" " -f1)

		for m in $screens; do
			if [[ $primary == "$m" ]]; then
				MONITOR=$m TRAY_POS=right polybar laptop &
			else
				MONITOR=$m TRAY_POS=none polybar secondary &
			fi
		done
	fi
else
	MONITOR=$(polybar --list-monitors | cut -d":" -f1) TRAY_POS=right polybar desktop &
fi
