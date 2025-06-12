#!/bin/bash

volume=$(pamixer --get-volume)
muted=$(pamixer --get-mute)

if [ "$muted" = "true" ]; then
    echo '{"text": "[Muted]"}'
    exit
fi

bar=""
full_blocks=$((volume / 10))
empty_blocks=$((10 - full_blocks))

for ((i=0; i<full_blocks; i++)); do
    bar+="█"
done
for ((i=0; i<empty_blocks; i++)); do
    bar+="░"
done

echo "{\"text\": \"$bar $volume%\"}"
