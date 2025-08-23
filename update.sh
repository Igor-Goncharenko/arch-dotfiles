#!/bin/bash
rm -rf config/

mkdir -p config/
cp -rf ~/.config/{i3,i3blocks,btop,nvim,tmux,alacritty,qt5ct} config/

mkdir -p config/doublecmd
cp -f ~/.config/doublecmd/{doublecmd.xml,shortcuts.scf,highlighters.xml,extassoc.xml,tabs.xml,colors.json} config/doublecmd

cp -f ~/{.zshrc,.zprofile,.xinitrc,.xprofile} config/

rm config/nvim/lazy-lock.json
