#!/bin/bash

# Define options
options="Shutdown\nRestart\nSuspend\nLogout\nLock"

# Prompt user to select an option using Rofi
selected_option=$(echo -e "$options" | rofi -dmenu -p "Power Menu" -lines 6 -theme-str 'configuration {show-icons: false;} entry {placeholder: "Choose..."}')

if [ -z "$selected_option" ]; then
    exit 0
fi

# Function to display confirmation dialog
confirm_action() {
	rofi -dmenu -p "$1" <<<"Yes\nNo"
}

# Perform action based on selected option
case $selected_option in
"Shutdown")
	confirmation=$(confirm_action "Shutdown?")
	if [ "$confirmation" == "Yes" ]; then
		systemctl poweroff
	else
		exit 0
	fi
	;;
"Restart")
	confirmation=$(confirm_action "Restart?")
	if [ "$confirmation" == "Yes" ]; then
		systemctl reboot
	else
		exit 0
	fi
	;;
"Suspend")
	systemctl suspend
	;;
"Logout")
    confirmation=$(confirm_action "Logout?")
    if [ "$confirmation" == "Yes" ]; then
        i3-msg exit
    else
        exit 0
    fi
    ;;
"Lock")
	i3-msg exit
	;;
*)
	exit 0
	;;
esac
