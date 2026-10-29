if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Added by `rbenv init` on Wed Oct 29 15:35:39 EDT 2025
status --is-interactive; and rbenv init - --no-rehash fish | source

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
export PATH="$HOME/.local/bin:$PATH"

# opencode
fish_add_path $HOME/.opencode/bin

# Added by LM Studio CLI (lms)
set -gx PATH $PATH $HOME/.lmstudio/bin
# End of LM Studio CLI section

