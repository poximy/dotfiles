# brew pnpm config
export PATH="$PNPM_HOME:$PATH"
export PNPM_HOME="/Users/poximy/Library/pnpm"

# macOS Apple silicon
export PATH=/opt/homebrew/bin:$PATH

alias zshconfig="code ~/.zshrc"
alias fishconfig="code ~/.config/fish/config.fish"

alias gitconfig="code ~/.gitconfig"
alias nvimconfig="code ~/.config/nvim"

eval $(/opt/homebrew/bin/brew shellenv)
