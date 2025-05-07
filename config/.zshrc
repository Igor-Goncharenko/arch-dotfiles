export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export EDITOR='nvim'

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="eastwood"

# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias vim=nvim

