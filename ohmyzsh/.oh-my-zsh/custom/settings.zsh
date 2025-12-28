# HISTORY
# Increase history size (Default is usually too small)
HISTSIZE=50000
SAVEHIST=50000

# Share history between tabs immediately
# (If you run a migration in Tab 1, it appears in Tab 2's history instantly)
setopt SHARE_HISTORY

# Don't save duplicates
setopt HIST_IGNORE_ALL_DUPS

# Remove extra blanks from commands to save space
setopt HIST_REDUCE_BLANKS

# Don't save commands starting with a space (Secure for passwords/API keys)
setopt HIST_IGNORE_SPACE

# NAVIGATION
# Auto CD: Just type the directory name to enter it (no need to type 'cd')
# Example: typing 'public' takes you to ./public
setopt AUTO_CD

# Dir Stack: Make 'cd' push the old directory to a stack
# Allows you to use 'popd' or '-' to return to previous folders easily
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# SAFETY AND QOL
# Smart URLs: Automatically escapes special characters in URLs
# Lifesaver when curl-ing APIs with '?' or '&' parameters
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Safety: Wait 10 seconds before executing 'rm *' (Prevents accidents)
setopt RM_STAR_WAIT

# Paste: Disable highlighting when pasting text (speeds up large pastes)
zle_highlight+=(paste:none)

# Typos: Autocorrect commands (e.g., 'doker' -> 'docker')
setopt CORRECT

# Use a selection menu instead of just listing files
zstyle ':completion:*' menu select

# Colorize completions (matches your 'ls' colors)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Case insensitive completion (cd public matches Public, PUBLIC, etc.)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
