#!/bin/bash

set -e
packages=$(cat <<EOF
ansible
asdf
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
pry
shell
stumpwm
tmux
vim
x11
zsh
EOF
        )

# Remove all the .DS_Store files
find . -name .DS_Store -exec rm {} \;

for name in $packages; do
    echo "Stowing package $name"
    stow --dotfiles -t "$HOME" -v $name
done

if [ ! -e ~/.emacs-prelude.d ]; then
    git clone git://github.com/bbatsov/prelude.git ~/.emacs-prelude.d
fi
