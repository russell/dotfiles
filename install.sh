#!/bin/bash

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

maybe_symlink aliases ~/.bash_aliases
maybe_symlink aliases ~/.zaliases

maybe_symlink profile ~/.bash_profile
maybe_symlink profile ~/.zprofile


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
