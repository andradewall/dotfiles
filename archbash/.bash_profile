#
# ~/.bash_profile
#

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Adding GitHub key to SSH Agent
if ! ssh-add -l | grep -q "$(ssh-keygen -lf "$HOME/.ssh/github" | awk '{print $2}')" 2>/dev/null; then
    ssh-add "$HOME/.ssh/github" </dev/null
fi
