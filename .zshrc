export ZSH="$HOME/.oh-my-zsh"

# brew pnpm config
export PNPM_HOME="/Users/poximy/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# macOS Apple silicon
eval $(/opt/homebrew/bin/brew shellenv)

# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="minimal"

# Which plugins would you like to load?
# Add wisely, as too many plugins slow down shell startup.
plugins=(macos fancy-ctrl-z safe-paste copyfile)

alias zshconfig="code ~/.zshrc"
alias gitconfig="code ~/.gitconfig"
alias nvimconfig="code ~/.config/nvim/init.vim"

zstyle ':omz:update' mode auto

source $ZSH/oh-my-zsh.sh
