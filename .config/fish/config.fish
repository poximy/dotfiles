# alias
alias zshconfig="nvim ~/.zshrc"
alias fishconfig="nvim ~/.config/fish/config.fish"

alias gitconfig="nvim ~/.gitconfig"
alias nvimconfig="nvim ~/.config/nvim/"

# pnpm
set -gx PNPM_HOME "/Users/poximy/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
