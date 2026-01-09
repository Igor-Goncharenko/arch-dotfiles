export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export VCPKG_ROOT="/home/goncharenko/.local/share/vcpkg"
export PATH="$PATH:$VCPKG_ROOT"

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

alias get_idf='. $HOME/esp/esp-idf/export.sh'

[ -f "/home/goncharenko/.ghcup/env" ] && . "/home/goncharenko/.ghcup/env" # ghcup-env
alias docker=podman

