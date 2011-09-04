#!/bin/bash


for name in *; do
    target="$HOME/.$name"
    if [ -e $target ]; then
	if [ ! -L $target ]; then
		echo "WARNING: $target exists but is not a symlink."
	    else
		echo "WARNING: $target exists and is a symlink."
	fi
    else
	if [[ $name != 'install.sh' && $name != 'README' && $name != *~  && $name != *.orig && $name != \#*\# ]]; then
	    if [[ $name == *.local ]]; then
		echo "added local file $target"
		cp "$PWD/$name" "$target"
	    else
		echo "linked in $target"
		ln -s "$PWD/$name" "$target"
	    fi
	fi
    fi
done