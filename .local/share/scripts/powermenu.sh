#!/bin/bash

# Define options
options="Shutdown\nRestart\nSuspend\nLock"

# Prompt user to select an option using Rofi
selected_option=$(echo -e "$options" | rofi -dmenu -p "Power Menu")

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
"Lock")
	i3-msg exit
	;;
*)
	exit 0
	;;
esac
