export EDITOR=nvim
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
zinit light MichaelAquilina/zsh-auto-notify
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode

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
# Aliases
# ==========================

# File and directory shortcuts
alias ls='eza --long --all --no-permissions --no-filesize --no-user --no-time --git --color=always'
alias ll='ls -lh'
alias la='ls -la'
alias ~='cd ~'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Text and command preview
alias cat='bat --paging never --theme DarkNeon --style plain'
alias fzfp='fzf --preview "bat --style numbers --color always {}"'

# System shortcuts
alias vim='nvim'
alias vi='nvim'
alias c='clear'

# Personal shortcuts
alias dots='cd ~/dotfiles && nvim'

# History shortcuts
alias h='history | fzf'

# Tmux shortcuts
alias tx='tmux'
alias tks='tmux kill-session -t'
alias tls='tmux list-sessions'
alias tas='tmux attach-session -t'
alias tns='tmux new-session -s'
alias tks-all="tmux kill-server"

# ==========================
# Shell Integrations
# ==========================

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Yazi function
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

export PATH=$PATH:/home/gdam/.spicetify
