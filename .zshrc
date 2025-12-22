# ================================================================
# Modern Zsh Configuration with Zinit + Starship
# Created: 2025-12-16
# ================================================================

# ================================================================
# PATH Configuration
# ================================================================
export PATH=$HOME/.local/bin:$HOME/bin:$HOME/dev/flutter/bin:$HOME/.pub-cache/bin:$PATH

# Setup path for Golang
export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"

# Environment Variables
# ================================================================
# Set Chrome Executable for Flutter
export CHROME_EXECUTABLE=$(which google-chrome-stable)

# Set npm config prefix to store global packages
export npm_config_prefix="$HOME/.local"

# Set default editor
export EDITOR="nvim"

# ================================================================
# Zinit Plugin Manager Installation
# ================================================================
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if it doesn't exist
if [[ ! -d $ZINIT_HOME ]]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# ================================================================
# Starship Prompt
# ================================================================
eval "$(starship init zsh)"

# transient prompt
zle-line-init() {
  emulate -L zsh

  [[ $CONTEXT == start ]] || return 0

  while true; do
    zle .recursive-edit
    local -i ret=$?
    [[ $ret == 0 && $KEYS == $'\4' ]] || break
    [[ -o ignore_eof ]] || exit 0
  done

  local saved_prompt="$PROMPT"
  local saved_rprompt=$RPROMPT
  # PROMPT="%K{white}%F{black} ❯ %f%k "
  PROMPT="❯ %f%k "
  RPROMPT=''
  zle .reset-prompt
  PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt

  if (( ret )); then
    zle .send-break
  else
    zle .accept-line
  fi

  return ret
}

zle -N zle-line-init

# ================================================================
# Zinit Plugins (with Turbo Mode for fast loading)
# ================================================================

# Fish-like autosuggestions (loaded after prompt, turbo mode)
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Fast syntax highlighting (loaded after prompt, turbo mode)
zinit ice wait lucid
zinit light zdharma-continuum/fast-syntax-highlighting

# Additional completions (loaded after prompt, turbo mode)
zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions

# Oh My Zsh git plugin (for git aliases, turbo mode)
zinit ice wait lucid
zinit snippet OMZ::plugins/git/git.plugin.zsh

# Oh My Zsh AWS plugin (for AWS profile switching)
zinit ice wait lucid
zinit snippet OMZ::plugins/aws/aws.plugin.zsh

# Load completions
autoload -Uz compinit
compinit

# Zinit compinit optimization
zinit cdreplay -q

# ================================================================
# fzf Integration
# ================================================================
# Key bindings for fzf
# Ctrl+R: Search command history
# Ctrl+T: Find files
# Alt+C: Change directory
if [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
    source /usr/share/fzf/key-bindings.zsh
fi

if [[ -f /usr/share/fzf/completion.zsh ]]; then
    source /usr/share/fzf/completion.zsh
fi

# fzf configuration
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}' 2>/dev/null || cat {}"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# ================================================================
# Aliases
# ================================================================
alias vim="nvim"

# Modern replacements using eza (only if available)
if (( $+commands[eza] )); then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -lh --icons --group-directories-first --git'
  alias la='eza -lah --icons --group-directories-first --git'
  alias lt='eza --tree --level=2 --icons'
  alias tree='eza --tree --icons'
fi

# System
alias reload='exec zsh'
alias zedit='$EDITOR ~/.config/zsh/.zshrc'
alias zconf='cd ~/.config/zsh && $EDITOR .'
alias zsource='source ~/.config/zsh/.zshrc'

# Python
alias py='python3'
alias pip='python3 -m pip'
alias venv='python3 -m venv'
alias activate='source venv/bin/activate'
alias dactivate='deactivate'

# Utility
alias path='echo $PATH | tr ":" "\n"'
alias h='history'
alias c='clear'
alias cls='clear'
if (( $+commands[rg] )); then
  alias grep='rg'  # Use ripgrep instead
fi
if (( $+commands[fd] )); then
  alias find='fd'  # Use fd instead
fi

# ================================================================
# SSH and GPG Key Management
# ================================================================
# Start keychain for SSH and GPG key management
eval $(keychain --eval --quiet github cyon)

# ================================================================
# Zoxide (Smart Directory Jumper)
# ================================================================
eval "$(zoxide init zsh)"

# ================================================================
# Zsh Options
# ================================================================
# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# History options
setopt HIST_IGNORE_ALL_DUPS  # Remove older duplicate entries from history
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from history items
setopt INC_APPEND_HISTORY    # Save history entries as soon as they are entered
setopt SHARE_HISTORY         # Share history between all sessions

# Other useful options
setopt AUTO_CD               # Change directory by typing directory name
setopt AUTO_PUSHD            # Make cd push the old directory onto the directory stack
setopt PUSHD_IGNORE_DUPS     # Don't push multiple copies of the same directory
setopt INTERACTIVE_COMMENTS  # Allow comments in interactive shell

# ================================================================
# Custom Functions (Add your own below)
# ================================================================

# Example: Quickly reload zsh config
alias zshreload="source ~/.zshrc"

# AWS Profile Switcher with fzf (like awsp but built-in!)
aspf() {
    local profile
    profile=$(aws configure list-profiles 2>/dev/null | fzf --height 40% --reverse --prompt "AWS Profile: ")
    if [[ -n "$profile" ]]; then
        export AWS_PROFILE="$profile"
        echo "✓ Switched to AWS profile: $profile"
    fi
}

# AWS Profile Switcher with SSO login
aspfl() {
    local profile
    profile=$(aws configure list-profiles 2>/dev/null | fzf --height 40% --reverse --prompt "AWS Profile (SSO): ")
    if [[ -n "$profile" ]]; then
        export AWS_PROFILE="$profile"
        echo "✓ Switched to AWS profile: $profile"
        aws sso login
    fi
}

# ================================================================
# End of Configuration
# ================================================================
