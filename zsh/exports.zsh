# Environment variables and exports

# Editor configuration
export EDITOR=nvim

# Go configuration
export GO111MODULE=on
export GOPATH="$HOME/go"

# PyEnv configuration
export PYENV_ROOT="$HOME/.pyenv"

# Volta (Node.js) configuration
export VOLTA_HOME="$HOME/.volta"

# SSL certificates for local development
export LOUNGE_LOCAL_CERTIFICATE=/Users/sasaeed/code/zalando/zl-skipper/tools/proxy/_wildcard.local.zlounge.org.pem
export LOUNGE_LOCAL_CERTIFICATE_KEY=/Users/sasaeed/code/zalando/zl-skipper/tools/proxy/_wildcard.local.zlounge.org-key.pem

# Load sensitive environment variables from .env file
[[ -f ~/.dotfiles/zsh/.env ]] && source ~/.dotfiles/zsh/.env