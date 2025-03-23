#!/bin/bash

# Ensure Bluetooth is powered on
check_power() {
    if ! bluetoothctl show | grep -q "Powered: yes"; then
        notify-send "Bluetooth" "Turning on..." -t 2000
        bluetoothctl power on
        sleep 1
    fi
}

# Get list of paired devices and scan briefly
get_devices() {
    check_power
    bluetoothctl scan on >/dev/null 2>&1 &
    SCAN_PID=$!
    sleep 3
    kill $SCAN_PID 2>/dev/null
    bluetoothctl devices | grep Device | awk '{print $2 " - " substr($0, index($0,$3))}'
}

# Show devices in rofi
selected=$(get_devices | rofi -dmenu -p "Bluetooth Devices" -i)

# Handle connection/disconnection with notifications
if [ -n "$selected" ]; then
    mac=$(echo "$selected" | awk '{print $1}')
    device_name=$(echo "$selected" | awk '{print substr($0, index($0,$3))}')
    if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
        notify-send "Bluetooth" "Disconnecting $device_name..." -t 2000
        if bluetoothctl disconnect "$mac" >/dev/null 2>&1; then
            notify-send "Bluetooth" "$device_name disconnected" -t 3000
        else
            notify-send "Bluetooth" "Failed to disconnect $device_name" -u critical -t 3000
        fi
    else
        notify-send "Bluetooth" "Connecting to $device_name..." -t 2000
        if bluetoothctl connect "$mac" >/dev/null 2>&1; then
            # Double-check connection status
            if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
                notify-send "Bluetooth" "$device_name connected successfully" -t 3000
            else
                notify-send "Bluetooth" "Connection to $device_name failed" -u critical -t 3000
            fi
        else
            notify-send "Bluetooth" "Connection to $device_name failed" -u critical -t 3000
        fi
    fi
fi
