#!/bin/bash
if [[ -x /usr/bin/xbps-install ]]; then
    alias update='sudo xbps-install -Syu && rustup update'
    alias uninstall='sudo xbps-remove'
    alias install='sudo xbps-install -S'
    alias checkupdates='xbps-install -Mun'
elif [[ -x /usr/bin/pacman ]]; then
    alias update='sudo pacman -Syu --noconfirm && rustup update'
    alias uninstall='sudo pacman -Rsn'
    alias install='sudo pacman -S'
elif [[ -x /usr/bin/dpkg ]]; then
    alias update='sudo apt update && sudo apt upgrade && rustup update'
    alias uninstall='sudo apt remove'
    alias install='sudo apt install'
    alias checkupdates="sudo apt list --upgradable 2>/dev/null | wc -l"
    alias rg='rgrep'
    alias bat='batcat'
    alias fd='fdfind'
else
    echo "Couldn't find package manager"
fi

if [[ -x /usr/bin/systemctl ]]; then
    alias poweroff='sudo systemctl poweroff'
    alias reboot='sudo systemctl reboot'
elif [[ -x /usr/bin/loginctl ]]; then
    alias poweroff='sudo loginctl poweroff'
    alias reboot='sudo loginctl reboot'
else
    :
fi
