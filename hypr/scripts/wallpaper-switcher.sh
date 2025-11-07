#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
MONITOR1="eDP-1"
MONITOR2="HDMI-A-1"

CHOICE=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \
  \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) |
  sort | while read -r F; do
  FILENAME=$(basename "$F")
  echo -e "$FILENAME\0icon\x1f$F"
done | rofi -dmenu -p "Select Wallpaper:" -i -markup-rows -theme-str "element-icon { size: 100px; padding: 5px; } element-text { vertical-align: 0.5; padding: 0 10px; } listview { lines: 3; }")

if [[ -n "$CHOICE" ]]; then
  hyprctl hyprpaper preload "$WALLPAPER_DIR/$CHOICE"
  hyprctl hyprpaper wallpaper "$MONITOR1,$WALLPAPER_DIR/$CHOICE"
  hyprctl hyprpaper wallpaper "$MONITOR2,$WALLPAPER_DIR/$CHOICE"
fi
