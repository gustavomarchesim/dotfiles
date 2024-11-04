#!/bin/bash

# Define cores para a saída
GREEN="\033[0;32m"
NONE="\033[0m"

# Caminho para a pasta de backup
BACKUP_DIR=~/backup

# Arquivos e diretórios a serem copiados
backup_files=(
    ".config/kitty"
    ".config/mako"
    ".config/hypr"
    ".config/rofi"
    ".config/waybar"
    ".config/wlogout"
    ".zshrc"
)

# Função para criar diretórios se não existirem
create_directory() {
    dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo "Diretório $dir criado."
    fi
}

echo -e "${GREEN}"
figlet -f small "Backup"
echo -e "${NONE}"

# Função para criar backup
# Função para criar backup
create_backup() {
    # Cria a estrutura de diretórios de backup
    create_directory "$BACKUP_DIR"

    # Copia os arquivos e diretórios especificados
    for df in "${backup_files[@]}"; do
        echo ":: Backup de $df"
        if [ -d ~/"$df" ]; then
            # Se for um diretório, usa cp com -L para copiar o conteúdo
            cp -rL ~/"$df" "$BACKUP_DIR/"
        elif [ -f ~/"$df" ]; then
            # Se for um arquivo, copia diretamente
            cp -L ~/"$df" "$BACKUP_DIR/"
        else
            echo ":: $df não encontrado, pulando."
        fi
    done
}

# Pergunta ao usuário se deseja criar um backup
if gum confirm "Você deseja criar um backup agora?"; then
    create_backup
    echo ":: Backup concluído!"
else
    echo ":: Backup pulado."
fi

echo -e "${GREEN}"
figlet -f small "Atualizar"
echo -e "${NONE}"

# Atualiza o sistema
if gum confirm "Você deseja atualizar o sistema?"; then
    echo "Atualizando o sistema..."
    sudo pacman -Syu --noconfirm
fi

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

# Função para verificar se o pacote está instalado
_isInstalled() {
    package="$1"
    if pacman -Qs --color always "${package}" | grep -q "local"; then
        return 0 # verdadeiro
    fi
    return 1 # falso
}

echo -e "${GREEN}"
figlet -f small "Dependências"
echo -e "${NONE}"
    
# Função para instalar pacotes necessários
_installPackages() {
    toInstall=()
    for pkg in "$@"; do
        if _isInstalled "${pkg}"; then
            echo "${pkg} já está instalado."
            continue
        fi
        toInstall+=("${pkg}")
    done

    if [ ${#toInstall[@]} -eq 0 ]; then
        echo "Todos os pacotes já estão instalados."
        return
    fi

    printf "Pacotes não instalados:\n%s\n" "${toInstall[@]}"
    sudo pacman --noconfirm -S "${toInstall[@]}"
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
    "slurp"
    "grim"
    "grimblast-git"
    "mako"
    "rofi-wayland"
    "rofi-emoji"
    "seahorse"
    "waybar"
    "wlogout"
    "nwg-look"
    "zoxide"
    "fzf"
)

# Pergunta ao usuário se deseja instalar as dependências
if gum confirm "Você deseja instalar as dependências do projeto?"; then
    # Instala as dependências
    _installPackages "${dependencies[@]}"
    echo "Instalação das dependências concluída!"
else
    echo "Instalação das dependências pulada."
fi

# Cria os diretórios de configuração, se não existirem
mkdir -p ~/.config
mkdir -p ~/.local/share

# Usa o Stow para criar links simbólicos
echo -e "${GREEN}"
figlet -f small "Stow"
echo -e "${NONE}"
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

# Criar link simbólico para .zshrc
echo "Criando link simbólico para .zshrc..."
if [ -f "zsh/.zshrc" ]; then
    ln -sf "$(pwd)/zsh/.zshrc" "$HOME/.zshrc"
    echo ".zshrc linkado com sucesso."
else
    echo ".zshrc não encontrado."
fi

# Criar link simbólico para .p10k.zsh
echo "Criando link simbólico para .p10k.zsh..."
if [ -f "p10k/.p10k.zsh" ]; then
    ln -sf "$(pwd)/p10k/.p10k.zsh" "$HOME/.p10k.zsh"
    echo ".p10k.zsh linkado com sucesso."
else
    echo ".p10k.zsh não encontrado."
fi

# Criar link simbólico para .gitconfig
echo "Criando link simbólico para .gitconfig..."
if [ -f "gitconfig/.gitconfig" ]; then
    ln -sf "$(pwd)/gitconfig/.gitconfig" "$HOME/.gitconfig"
    echo ".gitconfig linkado com sucesso."
else
    echo ".gitconfig não encontrado."
fi

echo -e "${GREEN}"
figlet -f small "Concluído"
echo -e "${NONE}"
echo "Instalação e configuração concluídas! As dotfiles foram configuradas."
