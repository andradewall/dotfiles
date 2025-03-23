#!/bin/bash

# Generate full-year calendar for the current year
year=$(date +%Y)
calendar=$(cal -y "$year")

# Display it in yad (graphical) or rofi (menu-style)
# yad --text-info --title="Calendar $year" --width=600 --height=400 --text="$calendar" --no-buttons
# Alternative with rofi: uncomment below and comment yad line if preferred
echo "$calendar" | rofi -dmenu -p "Calendar $year" -width 50 -lines 20
