#!/bin/bash

# Get the current workspace ID
workspace_id=$(hyprctl activeworkspace | grep "workspace ID" | awk '{print $3}')

# Increment the workspace ID by 1
next_workspace_id=$((workspace_id + 1))

# Check if the next workspace ID exceeds the cap of 10
if [ "$next_workspace_id" -gt 10 ]; then
    next_workspace_id=1
fi

# Dispatch to the next workspace
hyprctl dispatch workspace "$next_workspace_id"
