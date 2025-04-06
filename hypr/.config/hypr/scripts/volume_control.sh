#!/bin/bash

# Check the argument: "up", "down", "mute", or "micmute"
case "$1" in
"up")
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ >/dev/null 2>&1
    ACTION="Increased"
    ;;
"down")
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- >/dev/null 2>&1
    ACTION="Decreased"
    ;;
"mute")
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle >/dev/null 2>&1
    IS_MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "MUTED")
    if [ "$IS_MUTED" == "MUTED" ]; then
        dunstify -a "Volume" "Volume Muted" "Audio is now muted" -t 2000
    else
        CURRENT_VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | cut -d. -f1)
        dunstify -a "Volume" "Volume Unmuted" "Current level: $CURRENT_VOLUME%" -h int:value:"$CURRENT_VOLUME" -t 2000
    fi
    exit 0
    ;;
"micmute")
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle >/dev/null 2>&1
    IS_MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -o "MUTED")
    if [ "$IS_MUTED" == "MUTED" ]; then
        dunstify -a "Volume" "Microphone Muted" "Mic is now muted" -t 2000
    else
        dunstify -a "Volume" "Microphone Unmuted" "Mic is now active" -t 2000
    fi
    exit 0
    ;;
*)
    echo "Usage: $0 {up|down|mute|micmute}"
    exit 1
    ;;
esac

# Get the current volume percentage (convert from decimal to percentage)
CURRENT_VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | cut -d. -f1)

# Check if muted (for up/down actions)
IS_MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "MUTED")
if [ "$IS_MUTED" == "MUTED" ]; then
    dunstify -a "Volume" "$ACTION Volume" "Muted" -t 2000
else
    notify-send -e -h int:value:"$CURRENT_VOLUME" -h string:x-canonical-private-synchronous:volume_notif -u low " Volume Level: $CURRENT_VOLUME%"
fi
