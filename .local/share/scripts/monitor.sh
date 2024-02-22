#!/bin/sh

if [ -f /usr/bin/envycontrol ]; then
	gpu_mode=$(/usr/bin/envycontrol -q)
	if [ "$gpu_mode" = "nvidia" ]; then
		xrandr --setprovideroutputsource modesetting NVIDIA-0
		xrandr --auto
		xrandr --output HDMI-0 --above eDP-1-1
		xrandr --output HDMI-0 --primary
	else
		xrandr --auto
		xrandr --output HDMI-1-0 --above eDP-1
		xrandr --output HDMI-1-0 --primary
	fi
fi

pkill picom
picom -b
