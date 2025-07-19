#!/bin/bash

STATE_FILE="$HOME/.config/hypr/.keyboard_layout"
LOG_FILE="$HOME/.config/hypr/.keyboard_layout.log"

# Initialize state file if it doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo "br" >"$STATE_FILE"
fi

CURRENT_LAYOUT=$(cat "$STATE_FILE")

# Toggle layout
if [ "$CURRENT_LAYOUT" = "br" ]; then
    if hyprctl keyword input:kb_layout us >>"$LOG_FILE" 2>&1; then
        echo "us" >"$STATE_FILE"
        echo '{"text":"US","tooltip":"US Layout"}'
    else
        echo '{"text":"Error","tooltip":"Failed to set US layout"}' | tee -a "$LOG_FILE"
    fi
else
    if hyprctl keyword input:kb_layout br >>"$LOG_FILE" 2>&1; then
        echo "br" >"$STATE_FILE"
        echo '{"text":"BR","tooltip":"BR Layout"}'
    else
        echo '{"text":"Error","tooltip":"Failed to set BR layout"}' | tee -a "$LOG_FILE"
    fi
fi
