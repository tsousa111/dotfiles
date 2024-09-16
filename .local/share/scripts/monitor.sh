#!/bin/sh

if [ -f /usr/bin/envycontrol ]; then
	gpu_mode=$(/usr/bin/envycontrol -q)
	if [ "$gpu_mode" = "nvidia" ]; then
		xrandr --setprovideroutputsource modesetting NVIDIA-0
		xrandr --auto
		xrandr --output HDMI-0 --above eDP-1-1
		xrandr --output HDMI-0 --primary
	else
        if [[ -n $(xrandr --listactivemonitors | grep HDMI-1-0) ]]; then
            xrandr --output eDP-1 --off --output HDMI-1-0 --auto
        else
            xrandr --auto
        fi
	fi
fi

pkill picom
picom -b
