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
DARWIN=false
if [ $(uname) == "Darwin" ]; then
  DARWIN=true;
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    dumb) ;;
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
    xterm) color_prompt=yes;;
    eterm-color) color_prompt=yes;;
    screen) color_prompt=yes;;
    screen-256color) color_prompt=yes;;
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
    if [ $(id -u) -eq 0 ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)\$ '
    fi
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

if [ "$COLORTERM" == "gnome-terminal" ]
then
    TERM=xterm-256color
fi


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
elif [ -x /usr/local/bin/gdircolors ]; then
    test -r ~/.dircolors && eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
fi

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

if command -v direnv > /dev/null; then
    eval "$(direnv hook bash)"
fi

if [ -f "$HOME/.bashrc.local" ]; then
    . "$HOME/.bashrc.local"
fi

export PATH="$HOME/.yarn/bin:$PATH"
