#!/bin/bash

files=$(cat <<EOF
ansible.cfg
bashrc
bazaar
conkerorrc
common.lisp
direnvrc
docker
dunstrc
eclrc
fonts.conf
gbp.conf
gitconfig
gitignore
gnus
gtkrc-2.0
gvimrc
hgrc
inputrc
keysnail.js
mutt
muttrc
pbuilderrc
profile
sbclrc
spacemacs
spacemacs.d
stumpwmrc
vim
vimrc
xmodmaprc
xbindkeysrc
Xresources
zsh
zshrc
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
    if [ ! -L $target ]; then
        symlink $name $target
    else
        echo "WARNING: $target exists but is not a symlink."
    fi
}

for name in $files; do
    symlink $name
done

maybe_symlink aliases ~/.bash_aliases
maybe_symlink aliases ~/.zaliases

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

mkdir -p ~/.config/gtk-3.0/
symlink config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
mkdir -p ~/.local/share/applications/
symlink local/share/applications/conkeror.desktop ~/.local/share/applications/conkeror.desktop
symlink local/share/applications/gnus.desktop ~/.local/share/applications/gnus.desktop
