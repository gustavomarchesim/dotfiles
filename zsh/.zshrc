if [[ -z "$TMUX" ]]; then
  fastfetch
fi
# ==========================
# Powerlevel10k Configuration
# ==========================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ==========================
# Zinit and Plugins
# ==========================

# Set the directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load Powerlevel10k with Zinit
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Load Zsh plugins
zinit light Aloxaf/fzf-tab
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit snippet OMZ::plugins/git
zinit snippet OMZP::sudo

# Load completions
autoload -Uz compinit && compinit

# Enable cd replay quietly

zinit cdreplay -q

# ==========================
#  Zstyle Configuration
# ==========================

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# ==========================
# History Configuration
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
# Navegação de Diretórios
# ==========================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias dl='cd ~/Downloads'
alias dc='cd ~/Documentos'
alias dots='cd ~/dotfiles && nvim'

# ==========================
# Listagem de Arquivos
# ==========================
alias ls='eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions'
alias tree='ls --tree --level=2'

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift
  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ==========================
# Busca e Ferramentas de Terminal
# ==========================
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias grep='grep --color'
alias c='clear'
alias h='history'

# ==========================
# Editor de Texto
# ==========================
alias vim='nvim'

# ==========================
# Tmux
# ==========================
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias tn='tmux new-session -s'

#==========================
# Shell Integrations
# ==========================

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
