#!/bin/bash

# Get the current workspace ID
workspace_id=$(hyprctl activeworkspace | grep "workspace ID" | awk '{print $3}')

# Decrement the workspace ID by 1
prev_workspace_id=$((workspace_id - 1))

# Check if the previous workspace ID goes below the minimum of 1
if [ "$prev_workspace_id" -lt 1 ]; then
    prev_workspace_id=10
fi

# Dispatch to the previous workspace
hyprctl dispatch workspace "$prev_workspace_id"
