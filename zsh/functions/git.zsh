# Git worktree management functions

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

# Function to remove a git worktree
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

# Function to force pull the current branch from origin
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

# Function to move between git worktrees using fzf
gwm() {
    local worktree
    worktree=$(git worktree list --porcelain | grep '^worktree ' | cut -d' ' -f2- | fzf)

    if [ -n "$worktree" ]; then
        cd "$worktree" || return
    fi
}