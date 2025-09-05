# GitHub CLI functions

# Function to browse PRs with fzf
function ghpr() {
    # Get current active GitHub account using API
    local current_account=$(gh api user --jq .login 2>/dev/null)
    
    if [[ -z "$current_account" ]]; then
        echo "Error: Unable to determine current GitHub account"
        return 1
    fi
    
    # Use account-specific cache directory
    local cache_dir="$HOME/.cache/ghpr/$current_account"
    local cache_file="$cache_dir/pr_list.txt"
    local raw_cache_file="$cache_dir/pr_list_raw.txt"
    local lock_file="$cache_dir/fetch.lock"
    
    # Create cache directory if it doesn't exist
    mkdir -p "$cache_dir"
    
    # Function to fetch PRs (silent)
    fetch_and_merge_prs() {
        # Use lock file to prevent multiple simultaneous fetches
        if [[ -f "$lock_file" ]]; then
            return
        fi
        touch "$lock_file"
        
        # Fetch new PRs (raw format without column formatting, including URL)
        local new_prs=$(
            {
                gh search prs --author="@me" --state=open --limit=100 --json repository,number,title,state,isDraft,url --jq '.[] | "\(.number)\t\(.repository.nameWithOwner)\t\(.title)\t\(.state)\t\(if .isDraft then "DRAFT" else "" end)\t\(.url)"' 2>/dev/null
                gh search prs --review-requested="@me" --state=open --limit=100 --json repository,number,title,state,isDraft,url --jq '.[] | "\(.number)\t\(.repository.nameWithOwner)\t\(.title)\t\(.state)\t\(if .isDraft then "DRAFT" else "" end)\t\(.url)"' 2>/dev/null
                gh search prs --reviewed-by="@me" --state=open --limit=100 --json repository,number,title,state,isDraft,url --jq '.[] | "\(.number)\t\(.repository.nameWithOwner)\t\(.title)\t\(.state)\t\(if .isDraft then "DRAFT" else "" end)\t\(.url)"' 2>/dev/null
            } | sort -t$'\t' -k2,2 -k1,1n -u
        )
        
        # Replace cache entirely with new data if we got results
        if [[ -n "$new_prs" ]]; then
            echo "$new_prs" > "$raw_cache_file"
            # Format for display (hide URL column)
            echo "$new_prs" | awk -F'\t' '{printf "%-6s %-40s %-60s %-6s %s\n", $1, $2, $3, $4, $5}' > "$cache_file"
        fi
        
        # Remove lock file
        rm -f "$lock_file"
    }
    
    # Check if we should refresh in background
    local cache_age=0
    if [[ -f "$cache_file" ]]; then
        cache_age=$(( $(date +%s) - $(stat -f %m "$cache_file" 2>/dev/null || echo 0) ))
        if [[ $cache_age -gt 120 ]]; then  # Refresh if cache is older than 2 minutes
            ( fetch_and_merge_prs & ) 2>&1 >/dev/null
        fi
    fi

    # If cache exists, fetch in background; otherwise fetch synchronously
    if [[ -f "$cache_file" ]] && [[ -s "$cache_file" ]]; then
        # Use existing cache
        local selected=$(cat "$cache_file" | fzf --ansi \
            --height=80% \
            --layout=reverse \
            --header="Account: $current_account | Select PR (ENTER to open, Ctrl+R to refresh)" \
            --bind="ctrl-r:reload(cat $cache_file)" \
            --preview-window=hidden)
    else
        # No cache, fetch synchronously for first run
        fetch_and_merge_prs
        if [[ -f "$cache_file" ]] && [[ -s "$cache_file" ]]; then
            local selected=$(cat "$cache_file" | fzf --ansi \
                --height=80% \
                --layout=reverse \
                --header="Account: $current_account | Select PR (ENTER to open, Ctrl+R to refresh)" \
                --bind="ctrl-r:reload(cat $cache_file)" \
                --preview-window=hidden)
        fi
    fi
    
    if [[ -n "$selected" ]]; then
        # Extract PR number and repo to find URL from raw cache
        local pr_num=$(echo "$selected" | awk '{print $1}')
        local repo=$(echo "$selected" | awk '{print $2}')
        
        if [[ -n "$pr_num" ]] && [[ -n "$repo" ]]; then
            # Find URL from raw cache file
            local url=$(grep -E "^${pr_num}\t${repo}\t" "$raw_cache_file" | cut -f6)
            if [[ -n "$url" ]]; then
                # Open URL directly without gh API call
                open "$url"
            else
                # Fallback to gh command if URL not found
                gh pr view "$pr_num" --repo "$repo" --web
            fi
        fi
    fi
}

# Function to clear ghpr cache for current or all accounts
function ghpr-clear-cache() {
    local current_account=$(gh api user --jq .login 2>/dev/null)
    
    if [[ "$1" == "all" ]]; then
        rm -rf "$HOME/.cache/ghpr"
        echo "Cleared all ghpr cache"
    else
        if [[ -z "$current_account" ]]; then
            echo "Error: Unable to determine current GitHub account"
            return 1
        fi
        rm -rf "$HOME/.cache/ghpr/$current_account"
        echo "Cleared ghpr cache for account: $current_account"
    fi
}