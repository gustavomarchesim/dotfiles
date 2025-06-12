#!/bin/bash

CONFIG_FILE="$HOME/.config/hypr/hyprland.conf"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Hyprland config file not found at $CONFIG_FILE"
    exit 1
fi

CURRENT_OPACITY=$(grep -E "^\s*active_opacity\s*=\s*" "$CONFIG_FILE" | awk -F'=' '{print $2}' | tr -d ' ')
CURRENT_OPACITY_2=$(grep -E "^\s*inactive_opacity\s*=\s*" "$CONFIG_FILE" | awk -F'=' '{print $2}' | tr -d ' ')

if [[ "$CURRENT_OPACITY" == "0.95" ]]; then
    NEW_OPACITY="1"
    INACTIVE_OPACITY="1"
    notify-send -i "Transpenecy" "📝 Switched into Note Mode" -t 1000
else
    NEW_OPACITY="0.95"
    INACTIVE_OPACITY="0.75"
    notify-send -i "Transpenecy" "Switched into Normal Mode" -t 1000
fi

sed -i "s/^\s*active_opacity\s*=\s*[0-9.]*/    active_opacity = $NEW_OPACITY/" "$CONFIG_FILE"
sed -i "s/^\s*inactive_opacity\s*=\s*[0-7.]*/    inactive_opacity = $INACTIVE_OPACITY/" "$CONFIG_FILE"

echo "Toggled active_opacity to $NEW_OPACITY"

hyprctl reload
