#!/usr/bin/env bash
# ────────────────────────────────────────────────────────────────────
#  「✦ WALLPAPER PICKER ✦ 」
# ────────────────────────────────────────────────────────────────────
# INTERACTIVE WALLPAPER SELECTOR USING ROFI WITH PYWAL COLOR GENERATION
# ────────────────────────────────────────────────────────────────────

set -u

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/Wallpapers}"

CHOICE=$(
  find "$WALLPAPER_DIR" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) |
    sort |
    while IFS= read -r f; do
      printf '%s\0icon\x1f%s\n' "$(basename "$f")" "$f"
    done |
    rofi -dmenu -i -show-icons \
      -p "Select Wallpaper" \
      -theme "$HOME/.config/rofi/themes/glass-pywal.rasi" \
      -theme-str '
      listview {
        columns: 4;
        fixed-height: false;
        spacing: 12px;
      }

      element {
        orientation: vertical;
        padding: 6px;
      }

      element-icon {
        size: 200px;
        horizontal-align: 0.5;
      }

      element-text {
        horizontal-align: 0.5;
      }
      '
)

[[ -z "$CHOICE" ]] && exit 0

WALLPAPER="$WALLPAPER_DIR/$CHOICE"

[[ ! -f "$WALLPAPER" ]] && exit 1

hyprctl hyprpaper wallpaper ",$WALLPAPER," || {
  notify-send "Wallpaper Error" "hyprpaper failed"
  exit 1
}

wal -i "$WALLPAPER" -n -q
notify-send "Wallpaper Updated" "$CHOICE" -i "$WALLPAPER"
