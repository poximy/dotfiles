eval "$(starship init zsh)"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# brew pnpm config
export PATH="$PNPM_HOME:$PATH"
export PNPM_HOME="/Users/poximy/Library/pnpm"

# macOS Apple silicon
export PATH=/opt/homebrew/bin:$PATH

alias zshconfig="nvim ~/.zshrc"
alias nvim=".config/fish/config.fish"

alias gitconfig="nvim ~/.gitconfig"
alias nvimconfig="nvim ~/.config/nvim"

eval $(/opt/homebrew/bin/brew shellenv)
