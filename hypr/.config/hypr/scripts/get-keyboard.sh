#!/bin/bash

STATE_FILE="$HOME/.config/hypr/.keyboard_layout"

# Default to br if state file doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo "br" >"$STATE_FILE"
fi

CURRENT_LAYOUT=$(cat "$STATE_FILE")

if [ "$CURRENT_LAYOUT" = "br" ]; then
    echo '{"text":"BR","tooltip":"BR Layout"}'
else
    echo '{"text":"US","tooltip":"US Layout"}'
fi
