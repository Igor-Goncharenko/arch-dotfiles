#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

export QT_QPA_PLATFORMTHEME="qt5ct"
#export QT_STYLE_OVERRIDE="gtk2"

exec i3

