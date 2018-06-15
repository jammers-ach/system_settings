#!/bin/bash

# packages to install for first time installation
set -x
sudo apt instal xmonad xmobar dmenu vim-gtk trayer
mkdir ~/.xmonad
ln `pwd`/* ~/.xmonad/
ln ~/.xmonad/xmobarrc ~/.xmobarrc
echo "read https://askubuntu.com/questions/248/how-can-i-show-or-hide-boot-messages-when-ubuntu-starts"
