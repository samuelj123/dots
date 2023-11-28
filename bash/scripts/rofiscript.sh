#!/usr/bin/env bash

# Define power menu options
options=("Shutdown" "Restart Hyprland" "Restart" "Logout")

# Display Rofi menu and get user selection
selected_option=$(for option in  "${options[@]}"; do echo "$option"; done | rofi -dmenu -p "Power Menu:" -theme config)

# Execute the selected action
case $selected_option in
	"Shutdown")
		systemctl poweroff
		;;
	"Restart Hyprland")
		hyprctl reload
		;;
	"Restart")
		systemctl reboot
		;;
	"Logout")
		hyprctl dispatch exit
		;;
	*)
		echo "Invalid option"
		;;
esac
