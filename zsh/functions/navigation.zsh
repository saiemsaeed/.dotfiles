# File and directory navigation functions

# YAZI file manager with cd integration
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Enhanced cd function with automatic GitHub account switching
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

# Fast directory navigation with sam-finder
alias zsf='z "$(sam-finder)"'