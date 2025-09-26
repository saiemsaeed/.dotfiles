# Package.json script runner with fzf integration

run_scripts() {
    # Check if we're in a directory with package.json
    if [[ ! -f "package.json" ]]; then
        echo "❌ No package.json found in current directory"
        return 1
    fi

    # Check if jq is installed
    if ! command -v jq &> /dev/null; then
        echo "❌ jq is required but not installed. Install with: brew install jq"
        return 1
    fi

    # Check if fzf is installed
    if ! command -v fzf &> /dev/null; then
        echo "❌ fzf is required but not installed. Install with: brew install fzf"
        return 1
    fi

    # Extract scripts from package.json
    local scripts=$(jq -r '.scripts | to_entries[] | "\(.key): \(.value)"' package.json 2>/dev/null)
    
    if [[ -z "$scripts" ]]; then
        echo "❌ No scripts found in package.json"
        return 1
    fi

    # Use fzf to select a script
    local selected=$(echo "$scripts" | fzf --prompt="Select script to run: " --height=40% --border)
    
    if [[ -z "$selected" ]]; then
        echo "No script selected"
        return 0
    fi

    # Extract script name (everything before the first colon)
    local script_name=$(echo "$selected" | cut -d':' -f1)
    
    # Get the package manager from environment variable (defaults to yarn)
    local package_manager=${PACKAGE_MANAGER:-yarn}
    
    echo "🚀 Running: $package_manager run $script_name"
    echo "📄 Command: $(echo "$selected" | cut -d':' -f2- | sed 's/^ *//')"
    echo ""
    
    # Run the selected script
    $package_manager run "$script_name"
}