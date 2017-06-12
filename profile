# -*- mode: sh -*-
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# Debian doesn't seem to have a TMPDIR variable any more :(
[ -z "$TMPDIR" ] && TMPDIR=/tmp/


if [ $DARWIN -eq 1 ]; then
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
    export PATH="/usr/local/bin:$PATH"
fi

# Android SDK
if [ -d "/opt/android-sdk-linux_x86/tools/" ] ; then
    PATH="/opt/android-sdk-linux_x86/tools/:$PATH"
fi

# OSX texinfo support
if [ -d "/usr/texbin/" ]
then
    PATH="/usr/texbin/:$PATH"
fi

# Python home dir virtualenv
if [ -d "$HOME/.virtualenv" ]
then
    PATH="$HOME/.virtualenv/bin/:$PATH"
fi

# Common Lisp
if [ -d "$HOME/.cim" ]; then
    CIM_HOME=$HOME/.cim;
    if [ -s "$CIM_HOME/init.sh" ]; then
        . "$CIM_HOME/init.sh"
    fi
fi

# Emacs
if [ -d "$HOME/.cask" ]; then
  PATH="$HOME/.cask/bin:$PATH"
fi


# NodeJS
export NPM_PACKAGES="$HOME/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
if [ ! -d "$NPM_PACKAGES" ] ; then
    mkdir $NPM_PACKAGES
fi

# Home dir bin
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Guile scheme path
join () {
    local IFS="$1";
    shift;
    echo "$*";
}
export GUILE_LOAD_PATH=$(join ';' `find ~/projects/scheme/ -mindepth 1 -type d`)

if [ -d "/usr/local/MacGPG2/bin/" ]; then
    PATH="/usr/local/MacGPG2/bin/:$PATH"
fi

export GPGKEY=22B1092ADDDC47DD

export MAIL="russell.sim@gmail.com"
export DEBEMAIL=$MAIL
export DEBFULLNAME="Russell Sim"
export CC="gcc"


alias gtypist="gtypist -bi"

gread_link () {
    TARGET_FILE=$1

    cd `dirname $TARGET_FILE`
    TARGET_FILE=`basename $TARGET_FILE`

    # Iterate down a (possible) chain of symlinks
    while [ -L "$TARGET_FILE" ]
    do
        TARGET_FILE=`readlink $TARGET_FILE`
        cd `dirname $TARGET_FILE`
        TARGET_FILE=`basename $TARGET_FILE`
    done

    # Compute the canonicalized name by finding the physical path
    # for the directory we're in and appending the target file.
    PHYS_DIR=`pwd -P`
    RESULT=$PHYS_DIR/$TARGET_FILE
    echo $RESULT
}

# PDSH
export PDSH_RCMD_TYPE="ssh"
export PDSH_GENDERS_FILE=$(gread_link ~/.genders)

# git-buildpackage default target.
export DIST=unstable
export ARCH=amd64

# Python virtualenv/pip
#export PYTHONDONTWRITEBYTECODE=true
export WORKON_HOME=~/.virtualenvs/
export PIP_DOWNLOAD_CACHE=~/.egg-cache

export PATH
export MANPATH

export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

#
# grep colors
#
export GREP_COLOR='1;32'

#
# Less Colors for Man Pages
#

export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;33;246m'   # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
