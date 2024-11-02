#!/bin/bash

echo "Iniciando a instalação das dotfiles..."

# Atualiza o sistema
echo "Atualizando o sistema..."
sudo pacman -Syu --noconfirm

# Função para instalar o Paru
install_paru() {
    if ! command -v paru &> /dev/null; then
        echo "Paru não encontrado. Instalando..."

        # Verifica se o git e base-devel estão instalados
        if ! command -v git &> /dev/null || ! pacman -Qq | grep -qw base-devel; then
            echo "Instalando git e base-devel..."
            sudo pacman -S --noconfirm git base-devel
        fi

        # Clona o repositório do Paru
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si --noconfirm
        cd ..
        rm -rf paru
    fi
}

# Função para instalar o Stow
install_stow() {
    if ! command -v stow &> /dev/null; then
        echo "Stow não encontrado. Instalando..."
        sudo pacman -S --noconfirm stow
    fi
}

# Instala Paru e Stow
install_paru
install_stow

install_dependencies() {
    echo "Verificando e instalando dependências..."
    for pkg in "${dependencies[@]}"; do
        if ! paru -Qi "$pkg" &> /dev/null; then
            echo "$pkg não encontrado. Instalando..."
            paru -S --noconfirm "$pkg"
        else
            echo "$pkg já está instalado."
        fi
    done
}

# Lista de dependências
dependencies=(
    "kitty"
    "thunar"  
    "hypridle"
    "hyprpaper"
    "hyprpicker"
    "hyprshot"
    "zsh"
    "yad"
    "mako"
    "rofi-wayland"
    "rofi-emoji"
    "waybar"
    "wlogout"
    "nwg-look"
    "zoxide"
    "fzf"
)

# Chama a função para instalar as dependências
install_dependencies

# Cria os diretórios de configuração, se não existirem
mkdir -p ~/.config
mkdir -p ~/.local/share

# Usa o Stow para criar links simbólicos
echo "Criando links simbólicos com o Stow..."

# Stow as configurações de .config
if [ -d ".config" ]; then
    stow -v --target=$HOME/.config .config
else
    echo "Diretório .config não encontrado."
fi

# Stow as configurações de .local
if [ -d ".local" ]; then
    stow -v --target=$HOME/.local .local
else
    echo "Diretório .local não encontrado."
fi

# Stow as outras configurações na raiz do usuário
echo "Criando link simbólico para .zshrc..."
if [ -f "zsh/.zshrc" ]; then
    ln -sf "$(pwd)/zsh/.zshrc" "$HOME/.zshrc"
    echo ".zshrc linkado com sucesso."
else
    echo ".zshrc não encontrado."
fi

echo "Instalação concluída! As dotfiles foram configuradas."
