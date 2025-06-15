#!/bin/bash

# Check if swww is running and kill it
if pgrep -x "swww" > /dev/null; then
    killall swww
fi

TARGET="$HOME/Pictures/Wallpaper"

WALLPAPER=$(find "$TARGET" -type f -iregex '.*\.\(jpg\|jpeg\|png\|webp\)' | shuf -n 1)

if [ -z "$WALLPAPER" ]; then
    echo "Error: No wallpapers found in $TARGET."
    exit 1
fi

if ! pgrep -x "swww" > /dev/null; then
    swww init
    sleep 1
fi

swww img $WALLPAPER --transition-type outer --transition-fps=144 --transition-duration=1

echo "Wallpaper set to: $WALLPAPER"
