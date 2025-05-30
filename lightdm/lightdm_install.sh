#!/bin/bash
echo -n "Install/Update requirements (lightdm, lightdm-gtk-greeter, gruvbox-dark-gtk) [Y/n]? "
read install_ans

if [ $install_ans == "y" ] || [ $install_ans == "Y" ] ; then
    yay -S lightdm lightdm-gtk-greeter gruvbox-dark-gtk -y
fi

sudo mkdir -p /etc/lightdm

echo -n "Make backups of your files? [Y/n] "
read backup_ans

wallpaper=./../wallpapers/background_1920x1200.jpg

if [ $backup_ans == "y" ] || [ $backup_ans == "Y" ] ; then
    sudo cp --backup --suffix=".bak" $wallpaper /etc/lightdm/
    sudo cp --backup --suffix=".bak" ./lightdm.conf /etc/lightdm/lightdm.conf
    sudo cp --backup --suffix=".bak" ./lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
else
    sudo cp $wallpaper /etc/lightdm/
    sudo cp ./lightdm.conf /etc/lightdm/lightdm.conf
    sudo cp ./lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
fi

echo "Done"
