# Homebrew (adds /opt/homebrew/bin and sbin to PATH)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section

# Minimal prompt: just the current directory
PROMPT='%F{blue}%1~%f %# '

# Machine-specific settings and secrets (not committed)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
