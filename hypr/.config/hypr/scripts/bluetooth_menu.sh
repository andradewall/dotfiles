#!/bin/bash

# Ensure Bluetooth is powered on
check_power() {
    if ! bluetoothctl show | grep -q "Powered: yes"; then
        notify-send "Bluetooth" "Turning on..."
        bluetoothctl power on
        sleep 1
    fi
}

# Get list of paired devices and scan briefly
get_devices() {
    check_power
    # Start scanning in the background
    bluetoothctl scan on >/dev/null 2>&1 &
    SCAN_PID=$!
    sleep 3                    # Scan for 3 seconds
    kill $SCAN_PID 2>/dev/null # Stop scanning
    # List paired/known devices
    bluetoothctl devices | grep Device | awk '{print $2 " - " substr($0, index($0,$3))}'
}

# Show devices in rofi
selected=$(get_devices | rofi -dmenu -p "Bluetooth Devices" -i)

# Handle connection/disconnection
if [ -n "$selected" ]; then
    mac=$(echo "$selected" | awk '{print $1}')
    if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
        notify-send "Bluetooth" "Disconnecting $mac"
        bluetoothctl disconnect "$mac"
    else
        notify-send "Bluetooth" "Connecting to $mac"
        bluetoothctl connect "$mac"
    fi
fi
