#!/bin/bash

# Ensure NetworkManager is running
if ! systemctl is-active NetworkManager >/dev/null; then
    notify-send "NetworkManager" "Service not running. Starting it..." -t 2000
    sudo systemctl start NetworkManager
    sleep 1
fi

# Auto-connect to a known network if not connected
if ! nmcli -t -f STATE con show --active | grep -q "activated"; then
    known_network=$(nmcli -t -f NAME,TYPE con show | grep "wifi" | cut -d: -f1 | head -n1)
    if [ -n "$known_network" ]; then
        notify-send "Wi-Fi" "Auto-connecting to $known_network..." -t 2000
        nmcli con up "$known_network" >/dev/null 2>&1
    fi
fi

# Function to scan and list unique Wi-Fi networks
get_networks() {
    notify-send "Wi-Fi" "Scanning for networks..." -t 2000
    nmcli -f SSID,SIGNAL,SECURITY dev wifi list --rescan yes >/tmp/wifi_list
    awk 'NR>1 && $1 != "" && !seen[$1]++ {print $1 " - " $2 "% - " $3}' /tmp/wifi_list
}

# Show networks in rofi
selected=$(get_networks | rofi -dmenu -p "Wi-Fi Networks" -i)

# Handle connection
if [ -n "$selected" ]; then
    ssid=$(echo "$selected" | awk '{print $1}')
    current=$(nmcli -t -f NAME con show --active | head -n1)

    if [ "$current" = "$ssid" ]; then
        notify-send "Wi-Fi" "Disconnecting from $ssid..." -t 2000
        if nmcli con down "$ssid" >/dev/null 2>&1; then
            notify-send "Wi-Fi" "$ssid disconnected" -t 3000
        else
            notify-send "Wi-Fi" "Failed to disconnect $ssid" -u critical -t 3000
        fi
    else
        if nmcli con show "$ssid" >/dev/null 2>&1; then
            notify-send "Wi-Fi" "Connecting to $ssid..." -t 2000
            if nmcli con up "$ssid" >/dev/null 2>&1; then
                notify-send "Wi-Fi" "$ssid connected successfully" -t 3000
            else
                notify-send "Wi-Fi" "Connection to $ssid failed" -u critical -t 3000
            fi
        else
            security=$(echo "$selected" | awk '{print $5}')
            if [[ "$security" =~ "WPA" || "$security" =~ "WEP" ]]; then
                password=$(rofi -dmenu -p "Enter password for $ssid" -password -lines 0)
                if [ -n "$password" ]; then
                    notify-send "Wi-Fi" "Connecting to $ssid..." -t 2000
                    if nmcli dev wifi connect "$ssid" password "$password" >/dev/null 2>&1; then
                        nmcli con mod "$ssid" connection.autoconnect yes # Save for auto-connect
                        notify-send "Wi-Fi" "$ssid connected successfully" -t 3000
                    else
                        notify-send "Wi-Fi" "Connection to $ssid failed" -u critical -t 3000
                    fi
                else
                    notify-send "Wi-Fi" "Password required for $ssid" -u critical -t 3000
                fi
            else
                notify-send "Wi-Fi" "Connecting to $ssid..." -t 2000
                if nmcli dev wifi connect "$ssid" >/dev/null 2>&1; then
                    nmcli con mod "$ssid" connection.autoconnect yes # Save for auto-connect
                    notify-send "Wi-Fi" "$ssid connected successfully" -t 3000
                else
                    notify-send "Wi-Fi" "Connection to $ssid failed" -u critical -t 3000
                fi
            fi
        fi
    fi
fi

rm -f /tmp/wifi_list
