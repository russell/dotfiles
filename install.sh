#!/bin/bash

set -e
packages=$(cat <<EOF
alacritty
ansible
asdf
autokey
awesome
bash
bazaar
bazel
conkeror
debian
direnv
docker
dunst
emacs
git
keysnail
kitty
lisp
mercurial
mutt
nix
picom
pry
shell
starship
stumpwm
tmux
vim
x11
zsh
EOF
        )

# Remove all the .DS_Store files
find . -name .DS_Store -exec rm {} \;

mkdir -p ~/.config/systemd/user

for name in $packages; do
    echo "Stowing package $name"
    stow --dotfiles -t "$HOME" -v $name
done

systemctl --user enable xfce4-power-manager
systemctl --user enable picom

if [ ! -e ~/.emacs-prelude.d ]; then
    git clone git://github.com/bbatsov/prelude.git ~/.emacs-prelude.d
fi
