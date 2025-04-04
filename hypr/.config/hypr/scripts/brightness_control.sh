#!/bin/bash

# Check the argument: "up" or "down"
if [ "$1" == "up" ]; then
    brightnessctl s 10%+ >/dev/null 2>&1
    ACTION="Increased"
elif [ "$1" == "down" ]; then
    brightnessctl s 10%- >/dev/null 2>&1
    ACTION="Decreased"
else
    echo "Usage: $0 {up|down}"
    exit 1
fi

# Get the current brightness percentage
CURRENT_BRIGHTNESS=$(brightnessctl | grep "Current brightness" | awk '{print $4}' | tr -d '()%')

# Send notification via dunstify
dunstify -a "Brightness" "$ACTION Brightness" "Current level: $CURRENT_BRIGHTNESS%" -h int:value:"$CURRENT_BRIGHTNESS" -t 2000
