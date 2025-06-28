#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#
# FINISH ORIGINAL CONTENT BY ARCH LINUX
#

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# ###############################################
# ALIASES
# ###############################################

# Misc
alias ll="eza -lAG --icons=auto"
alias eb="nvim ~/.bashrc"
alias rb="source ~/.bashrc"
alias en="cd ~/.config/nvim/ && nvim ."
alias sb="cd ~/second-brain/ && nvim ."
alias zt="cd ~/second-brain/zettelkasten/ && nvim ."
alias ed="cd ~/dotfiles/ && nvim ."
alias lg="lazygit"

# Docker
alias dlsa="docker container ls --all"
alias dcudb="docker compose up -d --build"
alias dcud="docker compose up -d"
alias dcd="docker compose down"
alias de="docker exec"
alias deit="docker exec -it"

# Git
alias ga="git add ."
alias gcm="git commit -m"
alias gacm="ga; gcm"
alias gc="git checkout"
alias gst="git status"

# ###############################################
# PATH EXPORT
# ###############################################
export PATH="$PATH:/home/wallace/.local/bin"
export PATH="$PATH:/opt/nvim"
export PATH="$PATH:/home/wallace/.config/composer/vendor/bin"

# ###############################################
# SETTING APPS
# ###############################################
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --ansi'
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --color=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export BAT_THEME="Catppuccin Mocha"

# ###############################################
# CUSTOM FUNCTIONS
# ###############################################
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# ###############################################
# RUNNING APPS
# ###############################################
eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(fzf --bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Automatically start tmux in kitty
if [ -z "$TMUX" ]; then
    tmux attach-session -t default || tmux new-session -s default
fi
