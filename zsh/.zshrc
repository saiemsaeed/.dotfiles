# zmodload zsh/zprof
# Oh My Zsh plugins configuration
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)

# Load modular configuration files
for config in ~/.dotfiles/zsh/{exports.zsh,aliases.zsh,config/*.zsh,functions/*.zsh}; do
  [[ -r "$config" ]] && source "$config"
done


# zprof

export LOUNGE_LOCAL_CERTIFICATE=/Users/sasaeed/code/zalando/zl-skipper/tools/proxy/_wildcard.local.zlounge.org.pem
export LOUNGE_LOCAL_CERTIFICATE_KEY=/Users/sasaeed/code/zalando/zl-skipper/tools/proxy/_wildcard.local.zlounge.org-key.pem

# opencode
export PATH=/Users/sasaeed/.opencode/bin:$PATH
