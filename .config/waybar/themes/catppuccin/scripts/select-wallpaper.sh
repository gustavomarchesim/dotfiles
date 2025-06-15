#!/usr/bin/env bash

TARGET_DIR="${WALLPAPER_DIR:-$HOME/Pictures/Wallpaper}"
CONFIG_PATH="$HOME/.config/hypr/hyprpaper.conf"

TEMP_FILE=$(mktemp)

yazi --chooser-file "$TEMP_FILE" "$TARGET_DIR"

WALLPAPER=$(cat "$TEMP_FILE")
rm "$TEMP_FILE"

if [[ -z "$WALLPAPER" || ! -f "$WALLPAPER" ]]; then
    echo "No wallpaper selected. Exiting."
    exit 0
fi

mkdir -p "$(dirname "$CONFIG_PATH")"
{
    echo "preload = $WALLPAPER"
    echo "wallpaper = eDP-1,$WALLPAPER"
    echo "splash = off"
    echo "ipc = off"
} > "$CONFIG_PATH"

pkill hyprpaper
hyprctl dispatch exec "hyprpaper"

notify-send -a "hyprpaper" "Wallpaper Changed"  -i "$WALLPAPER"
echo "Wallpaper set to: $WALLPAPER"