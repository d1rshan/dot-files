#!/bin/bash

STATE_FILE="/tmp/hypr_focus_mode"

if [ -f "$STATE_FILE" ]; then
  hyprctl reload
  waybar &
  disown
  rm "$STATE_FILE"
else
  hyprctl keyword general:gaps_in 0
  hyprctl keyword general:gaps_out 0
  hyprctl keyword decoration:rounding 0
  hyprctl keyword decoration:active_opacity 1
  hyprctl keyword decoration:inactive_opacity 1
  hyprctl keyword decoration:blur:enabled 0
  pkill waybar
  touch "$STATE_FILE"
fi
