# Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
#  bindkey -s ^f "tmux-sessionizer\n"
alias zsf='z "$(sam-finder)"'
bindkey -s ^f "zsf\n"

# BREW PATH
eval $(/opt/homebrew/bin/brew shellenv)

# GO PATHS
export GO111MODULE=on
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"


export PATH="$PATH:$HOME/.local/bin"

# PYENV PATHS
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
if [ -n "$PS1" -a -n "$BASH_VERSION" ]; then source ~/.bashrc; fi

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh
source $(brew --prefix)/opt/fzf/shell/completion.zsh

export LOUNGE_LOCAL_CERTIFICATE=/Users/sasaeed/code/zalando/zl-skipper/tools/proxy/_wildcard.local.zlounge.org.pem
export LOUNGE_LOCAL_CERTIFICATE_KEY=/Users/sasaeed/code/zalando/zl-skipper/tools/proxy/_wildcard.local.zlounge.org-key.pem
eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
. "/Users/sasaeed/.deno/env"
eval "$(zoxide init zsh)"



# YAZI CONFIGURATION
export EDITOR=nvim
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function cd_func {
    # Store the previous directory before changing
    local prev_dir="$PWD"
    
    # Change directory using zoxide
    z "$@"
    
    # Store the new directory
    local new_dir="$PWD"
    
    # Check if we're transitioning into or out of zalando folder
    local prev_in_zalando=false
    local new_in_zalando=false
    
    [[ "$prev_dir" == *"code/zalando"* ]] && prev_in_zalando=true
    [[ "$new_dir" == *"code/zalando"* ]] && new_in_zalando=true
    
    # Only switch if we're actually transitioning
    if [[ "$prev_in_zalando" != "$new_in_zalando" ]]; then
        if [[ "$new_in_zalando" == true ]]; then
            # Moving into zalando folder
            local auth_status=$(gh auth status 2>&1)
            if [[ "$auth_status" == *"saiemsaeed (keyring)"* ]] && [[ "$auth_status" == *"Active account: true"* ]]; then
                echo "Switching to work account (saiem-saeed_zse)..."
                gh auth switch --hostname github.com --user saiem-saeed_zse
            fi
        else
            # Moving out of zalando folder
            local auth_status=$(gh auth status 2>&1)
            if [[ "$auth_status" == *"saiem-saeed_zse (keyring)"* ]] && [[ "$auth_status" == *"Active account: true"* ]]; then
                echo "Switching to personal account (saiemsaeed)..."
                gh auth switch --hostname github.com --user saiemsaeed
            fi
        fi
    fi
}

alias cd="cd_func"
alias vim="nvim"
alias vi="nvim"
alias lg="lazygit"
alias gco='git checkout'

# Function to create a general git worktree
gwc() {
    if [[ -z "$1" ]] || [[ -z "$2" ]]; then
        echo "Usage: gwc <path> <branch>"
        echo "Example: gwc ../feature-x feature/new-feature"
        return 1
    fi
    
    local WORKTREE_PATH=$1
    local BRANCH_NAME=$2
    
    # Check if branch exists locally or remotely
    if git show-ref --verify --quiet refs/heads/$BRANCH_NAME; then
        echo "Creating worktree for existing branch '$BRANCH_NAME'..."
    elif git show-ref --verify --quiet refs/remotes/origin/$BRANCH_NAME; then
        echo "Creating worktree for remote branch '$BRANCH_NAME'..."
    else
        echo "Branch '$BRANCH_NAME' doesn't exist. Creating new branch..."
        git branch $BRANCH_NAME
    fi
    
    # Create the worktree
    git worktree add "$WORKTREE_PATH" "$BRANCH_NAME"
    
    if [[ $? -eq 0 ]]; then
        echo "Successfully created worktree at $WORKTREE_PATH for branch $BRANCH_NAME"
    else
        echo "Failed to create worktree"
    fi
}

# Function to create a git worktree for a PR
gwp() {
    if [[ -z "$1" ]]; then
        echo "Usage: gwp <pr-number>"
        echo "Example: gwp 123"
        return 1
    fi
    
    local PR_NUM=$1
    local WORKTREE_DIR="pr-$PR_NUM"
    local BRANCH_NAME="pr-$PR_NUM"
    
    # If worktree already exists, remove it first
    if [[ -d "`pwd`/$WORKTREE_DIR" ]]; then
        echo "Worktree $WORKTREE_DIR already exists. Removing it first..."
        git worktree remove "`pwd`/$WORKTREE_DIR"
        git branch -D $BRANCH_NAME 2>/dev/null
    fi
    
    # Fetch the PR and create worktree
    echo "Fetching PR #$PR_NUM..."
    git fetch origin pull/$PR_NUM/head:$BRANCH_NAME
    
    if [[ $? -eq 0 ]]; then
        git worktree add "`pwd`/$WORKTREE_DIR" $BRANCH_NAME
        
        if [[ $? -eq 0 ]]; then
            echo "Successfully created worktree for PR #$PR_NUM at `pwd`/$WORKTREE_DIR"
            echo "You can now: cd $WORKTREE_DIR"
        else
            echo "Failed to create worktree for PR #$PR_NUM"
        fi
    else
        echo "Failed to fetch PR #$PR_NUM"
    fi
}


gwr() {
    echo "Are you sure you want to remove this worktree? (y/n)"
    read ans
    if [[ $ans = "y" || $ans = "yes" ]]; then
        if [[ -z "$1" ]]; then 
            # No argument provided - remove current worktree
            if git rev-parse --is-inside-work-tree &>/dev/null && [[ -f .git ]]; then
                # We're in a worktree (has .git file, not directory)
                WORKTREE_DIR=$(basename "$PWD")
                cd ..
                git worktree remove "$WORKTREE_DIR" && git branch -D "$WORKTREE_DIR"
            else 
                echo "Not inside a git worktree"
            fi
        else
            # PR number provided
            if git rev-parse --is-inside-work-tree &>/dev/null && [[ -f .git ]]; then
                # We're in a worktree
                CURRENT_DIR=$(basename "$PWD")
                if [[ "$CURRENT_DIR" == "pr-$1" ]]; then
                    # We're in the worktree we want to remove
                    cd ..
                    git worktree remove "pr-$1" && git branch -D "pr-$1"
                else
                    # We're in a different worktree, try to remove from parent
                    cd ..
                    git worktree remove "pr-$1" && git branch -D "pr-$1"
                fi
            else
                # We're not in a worktree, remove from current location
                git worktree remove "`pwd`/pr-$1" && git branch -D "pr-$1"
            fi
        fi
    else 
        echo "Worktree removal cancelled"
    fi
}

gpf() {
    # Get current branch name
    local CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    
    # Check if there are any changes (staged, unstaged, or untracked)
    if [[ -n $(git status --porcelain) ]]; then
        echo "Local changes detected. Stashing them..."
        git stash push -u -m "gpf auto-stash on $(date)"
        local STASHED=true
    else
        echo "No local changes to stash"
        local STASHED=false
    fi
    
    # Fetch and reset to remote branch
    echo "Fetching latest from origin..."
    git fetch origin
    
    echo "Force pulling from origin/$CURRENT_BRANCH..."
    git reset --hard origin/$CURRENT_BRANCH
    
    if [[ $? -eq 0 ]]; then
        echo "Successfully reset to origin/$CURRENT_BRANCH"
        
        # Pop stash if we stashed something
        if [[ $STASHED == true ]]; then
            echo "Applying stashed changes..."
            git stash pop
            
            if [[ $? -ne 0 ]]; then
                echo "Warning: Conflicts occurred while applying stash!"
                echo "Your changes are still in the stash. Use 'git stash list' to see them."
            else
                echo "Successfully applied stashed changes"
            fi
        fi
    else
        echo "Failed to reset to origin/$CURRENT_BRANCH"
        
        # If reset failed but we stashed, inform the user
        if [[ $STASHED == true ]]; then
            echo "Note: Your changes are still stashed. Use 'git stash pop' to retrieve them."
        fi
    fi
}

PROMPT_NEEDS_NEWLINE=false
precmd() {
  if [[ "$PROMPT_NEEDS_NEWLINE" == true ]]; then
    echo
  fi
  PROMPT_NEEDS_NEWLINE=true
}

clear() {
  PROMPT_NEEDS_NEWLINE=false
  command clear
}
