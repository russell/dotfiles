#!/bin/bash

set -e
packages=$(cat <<EOF
ansible
asdf
bash
bazaar
conkeror
debian
direnv
docker
dunst
emacs
git
keysnail
lisp
mercurial
mutt
shell
stumpwm
tmux
vim
x11
znt
zsh
EOF
        )

# Remove all the .DS_Store files
find . -name .DS_Store -exec rm {} \;

for name in $packages; do
    echo "Stowing package $name"
    stow --dotfiles -t "$HOME" -v $name
done

if [ ! -e ~/.emacs.d ]; then
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

if [ -L ~/.emacs ]; then
    rm -f ~/.emacs
fi
if [ -L ~/.emacs.d ]; then
    rm -f ~/.emacs.d
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi
