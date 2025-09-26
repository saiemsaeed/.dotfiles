# Command aliases and shortcuts

# Editor aliases
alias vim="nvim"
alias vi="nvim"

# Git aliases
alias lg="lazygit"
alias gco="git checkout"
alias gl="git log --oneline --graph --decorate --all"
alias gpo="git push origin"
alias gcm="git commit -m"
alias gwl="git worktree list"

# Zoxide
# alias cd="z"

#AI 
alias ai="claude"
alias cld="claude --dangerously-skip-permissions"

# AO function - updates ZTOKEN from ztoken script and runs opencode
function ao() {
    export ZTOKEN=$(ztoken)
    opencode
}

# Script runner
alias ss="run_scripts"

