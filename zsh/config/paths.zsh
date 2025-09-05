# PATH configuration and tool initialization

# Homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# Go binaries
export PATH="$GOPATH/bin:$PATH"

# Local binaries
export PATH="$PATH:$HOME/.local/bin"

# PyEnv
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
if [ -n "$PS1" -a -n "$BASH_VERSION" ]; then source ~/.bashrc; fi
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Volta (Node.js)
export PATH="$VOLTA_HOME/bin:$PATH"

# OpenJDK
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Deno
. "$HOME/.deno/env"

# FZF shell integration
source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh
source $(brew --prefix)/opt/fzf/shell/completion.zsh

# ZSH plugins (manual installation)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Tool initializations
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"