# -*- mode: sh -*-
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Debian doesn't seem to have a TMPDIR variable any more :(
[ -z "$TMPDIR" ] && TMPDIR=/tmp/

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Detect OSX
DARWIN=0
if [ $(uname) == "Darwin" ]; then
  DARWIN=1;
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    dumb) ;;
    xterm-color) color_prompt=yes;;
    xterm) color_prompt=yes;;
    eterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

# git prompt
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo " ("${ref#refs/heads/}")"
}


if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir, if it's an emacs term, do better
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;

    eterm-color*)
        # Setup tramp variables
        if [ -n "$SSH_CONNECTION" ]
        then
            _IP=$(echo -n $SSH_CONNECTION | cut -d\  -f3)
            _RHOSTNAME=$(host $_IP 2>/dev/null | sed -n 's/.*pointer \(.*\)[.]/\1/p')
            _HOSTIP=$(hostname -i 2>/dev/null)

            if [[ "$_IP" == "$_HOSTIP" ]]; then
                _HOST=$(hostname -f 2>/dev/null)
            elif [ -n "$_RHOSTNAME" ]; then
                _HOST=$_RHOSTNAME
            else
                _HOST=$_IP
            fi

        else
            _HOST=$(hostname -f 2>/dev/null)
        fi
        PROMPT_COMMAND='echo -ne "\033AnSiTh ${_HOST}\n\033AnSiTu ${USER}\n\033AnSiTc ${PWD/#$HOME/~}\n"'

        # Setup termcap file.
        LOCAL_EMACS_VERSION=$(ls -r /usr/share/emacs/ | grep -v site-lisp | head -n 1)
        if [ -n $LOCAL_EMACS_VERSION ]
        then
            export TERMINFO="/usr/share/emacs/$LOCAL_EMACS_VERSION/etc/"
        else
            echo "Can't find a local version of emacs."
        fi
        ;;

    *)
        ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ $DARWIN -eq 1 ]; then
    alias ls='ls -G'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

g () {
   grep -G -w --color=always --include="*.py" --include="*.xhtml" --include="*.tac" --include="*.po" -R "$@" ~/code/df
}


# EMACS launcher
e () {
    if [ $DARWIN -eq 1 ]; then
        EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs
    else
        EMACS=emacs
    fi
    EMACSCLIENT=emacsclient

    tempuid=`id -u`
    EMACSSERVER=$TMPDIR/emacs$tempuid/server

    if [ -f $HOME/.emacsconfig ]; then
        . $HOME/.emacsconfig
    fi

    if [ -z "$DISPLAY" ]; then
        exec $EMACS -n "$@"
    else
    if [ $DARWIN -eq 1 ]; then
        if [ -e "$EMACSSERVER" ]; then
            exec $EMACSCLIENT -n "$@" &
        else
            exec $EMACS --eval "(server-start)" "$@" &
        fi
    else
        if [ -e "$EMACSSERVER" ]; then
            $EMACSCLIENT -n "$@"
        else
            exec $EMACS --eval "(server-start)" "$@" &
        fi
    fi
    fi
}

# edit file with root privs
function E() {
         emacsclient -n -a emacs "/sudo:root@localhost:$PWD/$1"
}

# Mutt launcher
m () {
    offlineimap -1 -u quiet > /dev/null &
    OPID=$!
    mutt
    kill $OPID
    ps $OPID > /dev/null
    while [ $? -eq 0 ]; do
    kill $OPID
    sleep 3;
    ps $OPID > /dev/null
    done
    offlineimap -o -u basic
}

case "$TERM" in
    xterm*)
        export GIT_EDITOR="emacsclient"
        export BZR_EDITOR="emacsclient"
        ;;
    *)
        export GIT_EDITOR="emacs"
        export BZR_EDITOR="emacs"
        ;;
esac

#export PYTHONDONTWRITEBYTECODE=true

export PDSH_RCMD_TYPE="ssh"
export PDSH_GENDERS_FILE=`readlink -f ~/.genders`

# git-buildpackage default target.
export DIST=unstable
export ARCH=amd64

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -f "$HOME/.bashrc.local" ]; then
    . "$HOME/.bashrc.local"
fi
