#!/usr/bin/env bash

# --- Configuration ---
WALL_DIR="$HOME/Pictures/Wallpapers"
CACHE_DIR="$HOME/.cache/wallpaper-selector"
THUMB_W="300"
THUMB_H="200"

mkdir -p "$CACHE_DIR"

# --- Function: Generate Thumbnails ---
# Wofi struggles with high-res images, so we make small versions.
gen_thumb() {
  magick "$1" -thumbnail "${THUMB_W}x${THUMB_H}^" -gravity center -extent "${THUMB_W}x${THUMB_H}" "$2"
}

# --- Build the Wofi Menu ---
generate_menu() {
  for img in "$WALL_DIR"/*.{jpg,jpeg,png,webp}; do
    [[ -f "$img" ]] || continue

    thumb="$CACHE_DIR/$(basename "${img%.*}").png"

    # Only generate if thumb doesn't exist or image is newer
    if [[ ! -f "$thumb" ]] || [[ "$img" -nt "$thumb" ]]; then
      gen_thumb "$img" "$thumb"
    fi

    # Wofi format: img:PATH\x00info:NAME
    echo -en "img:$thumb\x00info:$(basename "$img")\n"
  done
}

# --- Execution ---
selected=$(generate_menu | wofi --show dmenu \
  --prompt "Select Wallpaper" \
  --allow-images \
  --columns 2 \
  --image-size 200 \
  --width 800 \
  --height 500 \
  --cache-file /dev/null)

# --- Apply Wallpaper ---
if [ -n "$selected" ]; then
  # Extract filename from the wofi selection
  # Wofi returns "img:/path/to/cache/file.png"
  # We need to map that back to the original file in $WALL_DIR
  filename=$(basename "${selected#img:}")
  # Remove the .png extension added by the cache and find the original
  raw_name="${filename%.*}"

  # Find the original file (supports different extensions)
  original=$(find "$WALL_DIR" -type f -name "$raw_name.*" | head -n 1)

  if [ -n "$original" ]; then
    # Hyprpaper Logic
    hyprctl hyprpaper preload "$original"
    hyprctl hyprpaper wallpaper ",$original"
    hyprctl hyprpaper unload all
    wal -i "$original" -n -q
    notify-send "Wallpaper Updated" "$(basename "$original")" -i "$original"
  fi
fi
