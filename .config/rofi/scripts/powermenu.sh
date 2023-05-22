#! /bin/sh
OPTIONS="Suspend\nLock\nReboot\nShutdown\nExit i3\n"

LAUNCHER="rofi -dmenu -i -p Power"
LOCKER="betterlockscreen -l"

option=$(printf '%s'"$OPTIONS" | $LAUNCHER | awk '{print $1}' | tr -d '\r\n')

if [ ${#option} -gt 0 ]
then
    case $option in
        Suspend)
           $LOCKER ;systemctl suspend
            ;; 
        Reboot)
            systemctl reboot
            ;;
        Lock)
            $LOCKER
            ;;
        Shutdown)
            systemctl poweroff
            ;;
        Exit)
            eval exit i3
            ;;
    esac
fi
