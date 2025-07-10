if [[ -z "$TMUX" ]]; then
  fastfetch
fi

# ==========================
# Prompt
# ==========================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ==========================
# Zinit
# ==========================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# ==========================
# Plugins
# ==========================
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light Aloxaf/fzf-tab
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light hlissner/zsh-autopair
zinit snippet OMZ::plugins/git
zinit snippet OMZP::sudo

autoload -Uz compinit && compinit
zinit cdreplay -q

# ==========================
# Zstyle
# ==========================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ==========================
# Histórico
# ==========================
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ==========================
# Navegação
# ==========================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias dl='cd ~/Downloads'
alias dc='cd ~/Documentos'
alias dots='cd ~/dotfiles && nvim'

# ==========================
# Listagem
# ==========================
alias ls='eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions'
alias tree='ls --tree --level=2'
alias la='eza --color=always --long --all --git --icons=always --no-filesize --no-user --no-time --no-permissions'

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"                         "$@" ;;
    ssh)          fzf --preview 'dig {}'                                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview"               "$@" ;;
  esac
}

# ==========================
# Extração
# ==========================
x() {
  local file="$1"
  local dest="${2:-.}"
  [ -z "$file" ] && echo "Uso: extract arquivo.ext [destino]" && return 1
  mkdir -p "$dest"
  case "$file" in
    *.zip) unzip "$file" -d "$dest" ;;
    *.tar) tar -xf "$file" -C "$dest" ;;
    *.tar.gz|*.tgz) tar -xzf "$file" -C "$dest" ;;
    *.tar.xz) tar -xJf "$file" -C "$dest" ;;
    *.tar.bz2) tar -xjf "$file" -C "$dest" ;;
    *.rar) unrar x "$file" "$dest" ;;
    *.7z) 7z x "$file" -o"$dest" ;;
    *) echo "Formato não suportado: $file" && return 2 ;;
  esac
}

# ==========================
# Buscas
# ==========================
alias grep='rg --smart-case --colors match:fg:green'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias c='clear'

# ==========================
# Arquivos
# ==========================
alias cat='bat --style=numbers,changes,header'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkd='mkdir -p'
alias take='mkdir -p $1 && cd $1'

# ==========================
# Editor
# ==========================
alias vim='nvim'

# ==========================
# Tmux
# ==========================
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'

# ==========================
# NPM
# ==========================
alias localhost='live-server --port=8081'

# ==========================
# Integrações
# ==========================
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

