#!/bin/bash

echo "Iniciando a instalação das dotfiles..."

# Atualiza o sistema
echo "Atualizando o sistema..."
sudo pacman -Syu --noconfirm || { echo "Erro ao atualizar o sistema."; exit 1; }

# Instala Stow se necessário
if ! command -v stow &> /dev/null; then
    echo "Stow não encontrado. Instalando..."
    sudo pacman -S --noconfirm stow || { echo "Erro ao instalar Stow."; exit 1; }
fi

# Função para instalar o Paru
install_paru() {
    if ! command -v paru &> /dev/null; then
        echo "Paru não encontrado. Instalando..."
        sudo pacman -S --noconfirm git base-devel || { echo "Erro ao instalar dependências do Paru."; exit 1; }
        git clone https://aur.archlinux.org/paru.git
        cd paru || exit 1
        makepkg -si --noconfirm
        cd ..
        rm -rf paru
    fi
}

install_paru

# Função para instalar as dependências
dependencies=(
    "kitty" "zsh" "fzf" "zoxide" "thunar" "waybar" "swww" "hyprshot"
    "slurp" "hyprpicker" "hypridle" "hyprlock" "yad" "mako" "rofi-wayland"
    "grim" "wlogout" "nwg-look" "tmux" "yazi"
)

install_dependencies() {
    echo "Verificando e instalando dependências..."
    for pkg in "${dependencies[@]}"; do
        if ! paru -Qi "$pkg" &> /dev/null; then
            echo "Instalando $pkg..."
            paru -S --noconfirm "$pkg" || { echo "Erro ao instalar $pkg."; exit 1; }
        else
            echo "$pkg já está instalado."
        fi
    done
}

install_dependencies

# Função para instalar o TPM
install_tmux_plugin_manager() {
    local tpm_dir="$HOME/.config/tmux/plugins/tpm"
    if [ -d "$tpm_dir" ]; then
        echo "TPM já está instalado. Pulando."
    else
        echo "Instalando o TPM..."
        git clone https://github.com/tmux-plugins/tpm "$tpm_dir" || { echo "Erro ao instalar o TPM."; exit 1; }
    fi
}

install_tmux_plugin_manager

# Cria os diretórios de configuração, se não existirem
mkdir -p ~/.config ~/.local/share

# Função para resolver conflitos com interação
resolve_conflicts_with_prompt() {
    file="$1"
    
    if [ -f "$HOME/$file" ]; then
        echo "O arquivo $file já existe no diretório $HOME."
        echo "O que você deseja fazer?"
        echo "1. Substituir pelo novo arquivo"
        echo "2. Manter o arquivo atual"
        echo "3. Fazer backup do arquivo atual e substituir"
        read -rp "Escolha uma opção (1/2/3): " choice

        case $choice in
            1)
                echo "Substituindo $file..."
                rm "$HOME/$file"
                ;;
            2)
                echo "Mantendo o arquivo atual. Pulando $file."
                return 1
                ;;
            3)
                echo "Fazendo backup de $file..."
                backup_dir="$HOME/dotfiles_backup_$(date +%Y%m%d%H%M%S)"
                mkdir -p "$backup_dir"
                mv "$HOME/$file" "$backup_dir/" || { echo "Erro ao mover $file."; exit 1; }
                echo "$file foi movido para $backup_dir."
                ;;
            *)
                echo "Opção inválida. Pulando $file."
                return 1
                ;;
        esac
    fi
    return 0
}

# Gerenciamento de arquivos pessoais
personal_files=("zsh" "p10k")

for dir in "${personal_files[@]}"; do
    if [ -d "$dir" ]; then
        # Detecta conflitos antes de stow
        for file in $(stow -nv --target="$HOME" "$dir" 2>&1 | grep "existing target" | awk '{print $NF}'); do
            if resolve_conflicts_with_prompt "$file"; then
                # Se o usuário escolheu substituir ou fazer backup, aplica o stow
                stow -v --target="$HOME" "$dir" || { echo "Erro ao processar $dir."; exit 1; }
            fi
        done
    else
        echo "Diretório $dir não encontrado. Pulando."
    fi
done

echo "Instalação concluída! As dotfiles foram configuradas com sucesso."
