# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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
alias ll="ls -lah --color=auto"
alias eb="nvim ~/.bashrc"
alias rb="source ~/.bashrc"
alias uu="echo 'RUNNING APT UPDATE...'; sudo apt update; echo 'RUNNING APT UPGRADE';  sudo apt upgrade; echo 'RUNNING FLATPAK UPDATE'; flatpak update; sudo apt autoremove"
alias en="cd ~/.config/nvim/ && nvim ."
alias sb="cd ~/second-brain/ && nvim ."
alias lg="lazygit"

alias changephp="sudo update-alternatives --config php"

alias sqlcli="mysql -u root -pdtdsv3010"

alias sh73="docker exec -it php-73 /bin/bash"
alias sh81="docker exec -it php-81 /bin/bash"
alias dlsa="docker container ls --all"

alias art="php artisan"
alias mfs="php artisan migrate:fresh --seed"
alias tp="php artisan test --parallel"
alias tc="vendor/bin/pest --compact"
alias aoc="php artisan optimize:clear"

alias nrb="npm run build"
alias nrbaoc="nrb && aoc"

alias pint="./vendor/bin/pint"
alias phpstan="./vendor/bin/phpstan"

alias ga="git add ."
alias gcm="git commit -m"
alias gacm="ga; gcm"
alias gc="git checkout"
alias gst="git status"

alias sail="./vendor/bin/sail"
alias sup="./vendor/bin/sail up"
alias sart="./vendor/bin/sail php artisan"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ###############################################
# PATH EXPORT
# ###############################################
export PATH="$PATH:/home/wallace/.local/bin"
export PATH="$PATH:/home/wallace/.config/composer/vendor/bin"
export PATH="$PATH:/opt/nvim"
export PATH="$PATH:/home/wallace/go/bin"

# ###############################################
# RUNNING APPS
# ###############################################
eval "$(starship init bash)"
eval "$(zoxide init bash)"
source /usr/share/doc/fzf/examples/key-bindings.bash

# [ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ###############################################
# SETTING APPS 
# ###############################################
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --ansi'
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --color=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
