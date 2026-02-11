#!/bin/bash
# ─────────────────────────────────────────────────────────────────────
#  「✦ FOCUS MODE TOGGLE ✦ 」
# ─────────────────────────────────────────────────────────────────────
# TOGGLES FOCUS MODE BY REMOVING GAPS, BORDERS, AND WAYBAR
# ─────────────────────────────────────────────────────────────────────

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
  pkill waybar
  touch "$STATE_FILE"
fi
