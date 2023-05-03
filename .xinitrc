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

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

if [[ -f /usr/bin/prime-offload ]]; then
    /usr/bin/prime-offload
fi

setxkbmap -layout us,pt
setxkbmap -option grp:win_space_toggle
xrandr --auto
xrandr --output HDMI-1-0 --above eDP-1
exec i3

if [[ -f /usr/bin/prime-switch ]]; then
    sudo /usr/bin/prime-switch
fi
