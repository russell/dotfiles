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

# Android SDK
if [ -d "/opt/android-sdk-linux_x86/tools/" ] ; then
    PATH="/opt/android-sdk-linux_x86/tools/:$PATH"
fi

# OSX texinfo support
if [ -d "/usr/texbin/" ]
then
    PATH="/usr/texbin/:$PATH"
fi

# Home dir virtualenv
if [ -d "$HOME/.virtualenv" ]
then
    PATH="$HOME/.virtualenv/bin/:$PATH"
fi

if [ -d "$HOME/.cim" ]; then
    CIM_HOME=/home/russell/.cim;
    if [ -s "$CIM_HOME/init.sh" ]; then
        . "$CIM_HOME/init.sh"
    fi
fi
