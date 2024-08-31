#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
	xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
	xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
	xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
	xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

if [ -f /usr/bin/prime-offload ]; then
	/usr/bin/prime-offload
fi

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/bin/xscreensaver -no-splash &
# setup monitors (laptop only)
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

exec i3
