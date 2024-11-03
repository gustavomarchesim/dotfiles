#!/bin/bash

set_random_wallpaper() {
    WALLPAPER_DIR="$HOME/dotfiles/.config/hypr/wallpapers"
    CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"
    LAST_WALLPAPER_FILE="$HOME/.config/hypr/last_wallpaper.txt"

    # Seleciona um wallpaper aleatório da pasta
    RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

    # Verifica se o arquivo do último wallpaper existe
    if [ -f "$LAST_WALLPAPER_FILE" ]; then
        LAST_WALLPAPER=$(cat "$LAST_WALLPAPER_FILE")
        # Se o novo wallpaper é igual ao último, seleciona um novo wallpaper
        while [ "$RANDOM_WALLPAPER" == "$LAST_WALLPAPER" ]; do
            RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
        done
    fi

    # Atualiza o arquivo do último wallpaper
    echo "$RANDOM_WALLPAPER" > "$LAST_WALLPAPER_FILE"

    # Gera o novo arquivo de configuração
    {
        echo "preload = $RANDOM_WALLPAPER"
        echo "wallpaper = , $RANDOM_WALLPAPER"
    } > "$CONFIG_FILE"

    # Verifica se o hyprpaper está rodando e mata o processo se necessário
    if pgrep -x "hyprpaper" > /dev/null; then
        pkill hyprpaper
    fi

    # Inicia o hyprpaper para aplicar as novas configurações
    hyprpaper &
}

set_random_wallpaper
