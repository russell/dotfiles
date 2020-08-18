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

function symlink {
    name=$1
    target=${2:-"$HOME/.$name"}
    if [ -e $target ]; then
      if [ ! -L $target ]; then
        echo "WARNING: $target exists but is not a symlink."
      fi
    else
      if [[ $name != *~  && $name != *.orig && $name != \#*\# ]]; then
          if [[ $name == *.local ]]; then
            echo "added local file $target"
            cp "$PWD/$name" "$target"
          else
            echo "linked in $target"
            ln -s "$PWD/$name" "$target"
          fi
      fi
    fi
}

function maybe_symlink {
    name=$1
    target=${2:-"$HOME/.$name"}
    if [ -e $target ]; then
        if [ ! -L $target ]; then
            echo "WARNING: $target exists but is not a symlink."
        fi
    else
        symlink $name $target
    fi
}

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
