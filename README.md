# dotfiles

macOS configs are symlinked into `$HOME` by `install.sh`, so edits made anywhere show up in `git status`.

| Repo | Linked to |
|---|---|
| `fish/` | `~/.config/fish` |
| `omf/` | `~/.config/omf` (Oh My Fish theme + bundle) |
| `ghostty/` | `~/.config/ghostty` |
| `nvim/` | `~/.config/nvim` (LazyVim) |
| `zsh/.zshrc` | `~/.zshrc` |
| `tmux/.tmux.conf` | `~/.tmux.conf` |
| `git/.gitconfig` | `~/.gitconfig` |

`doom/`, `sway/`, `termux/`, `nix/` and `.bashrc` are for other machines and aren't linked.

## New Mac

```sh
# 1. Command line tools + Homebrew
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Clone over HTTPS (no SSH key yet), then install everything in the Brewfile
git clone https://github.com/alhansrisuk/dotfiles.git ~/dotfiles
brew bundle --file ~/dotfiles/Brewfile

# 3. JetBrains Mono Nerd Font (all variants: NerdFont, Mono, Propo, NL) into ~/Library/Fonts
curl -fLo /tmp/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o /tmp/JetBrainsMono.zip '*.ttf' -d ~/Library/Fonts && rm /tmp/JetBrainsMono.zip

# 4. Oh My Fish (before linking, so its installer doesn't clobber the repo)
curl -fsSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# 5. Link configs (anything in the way goes to ~/.dotfiles-backup/)
~/dotfiles/install.sh

# 6. Install the bobthefish theme listed in omf/bundle
fish -c 'omf install'

# 7. Make fish the login shell
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish

# 8. Ruby
rbenv install 3.4.2 && rbenv global 3.4.2

# 9. Once an SSH key is added to GitHub, switch the remote so you can push
git -C ~/dotfiles remote set-url origin git@github.com:alhansrisuk/dotfiles.git
```

To update the Brewfile after installing or removing packages: `brew bundle dump --file ~/dotfiles/Brewfile --force` (then re-add the `cask "ghostty"` line if it was installed outside Homebrew).

Open nvim once and LazyVim installs its plugins from `nvim/lazy-lock.json`.

## Not tracked

- `fish/fish_variables`: fish's machine state; it's regenerated on first launch.
- `fish/conf.d/local.fish`: secrets and per-machine fish settings (e.g. `set -gx GEMINI_API_KEY ...`), loaded automatically by fish.
- `~/.zshrc.local`: secrets and per-machine zsh settings, sourced by `.zshrc` if present.
