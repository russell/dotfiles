# -*- mode: sh -*-
ZSHDIR=$HOME/.zsh
source $ZSHDIR/antigen.zsh
fpath=($ZSHDIR/completion $fpath)

antigen-bundle zsh-users/zsh-syntax-highlighting
antigen-bundle zsh-users/zsh-completions
gfpath=(~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-completions.git $fpath)

antigen-bundle git
antigen-bundle debian
antigen-bundle pip
antigen-apply

source ~/.zsh/plugins/virtualenvwrapper.plugin.zsh

# Disable underline of paths
ZSH_HIGHLIGHT_STYLES[path]='none'

# Debian doesn't seem to have a TMPDIR variable any more :(
[ -z "$TMPDIR" ] && TMPDIR=/tmp/

# Set up the prompt
if [[ $TERM == "dumb" ]]; then	# in emacs
    PS1='%(?..[%?])%!:%~%# '
    # for tramp to not hang, need the following. cf:
    # http://www.emacswiki.org/emacs/TrampMode
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
else
    setopt prompt_subst
    autoload -U colors
    colors
    source ~/.zsh/arrsim.zsh-theme
fi

# Example aliases
alias zshconfig="source ~/.zshrc"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Detect OSX
DARWIN=0
if [[ $(uname) == "Darwin" ]]; then
  DARWIN=1;
fi

setopt appendhistory histignorealldups sharehistory autocd extendedglob dvorak

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
bindkey '\ew' kill-region
bindkey -s '\el' "ls\n"
bindkey '^r' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF" end-of-line
bindkey ' ' magic-space    # also do history expansion on space

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey '^[[Z' reverse-menu-complete

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# use /etc/hosts and known_hosts for hostname completion
[ -r /etc/ssh/ssh_known_hosts ] && _global_ssh_hosts=(${${${${(f)"$(</etc/ssh/ssh_known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
  "$_global_ssh_hosts[@]"
  "$_ssh_hosts[@]"
  "$_etc_hosts[@]"
  "$HOST"
  localhost
)
zstyle ':completion:*:hosts' hosts $hosts

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios list proxy libuuid\
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs
# ... unless we really want to.
zstyle '*' single-ignored show


# make deleting part of a dns entry easier.
WORDCHARS=''

NOVA_DIR=/usr/local/src/python-novaclient
if [ -e $NOVA_DIR ]; then
    autoload -U bashcompinit;bashcompinit;source $NOVA_DIR/tools/nova.bash_completion
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ $SSH_TTY ]; then
    export GIT_EDITOR="emacs"
    export BZR_EDITOR="emacs"
else
    export GIT_EDITOR="emacsclient"
    export BZR_EDITOR="emacsclient"
fi

#
# ls colors
#

autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"
#export LS_COLORS

# Enable ls colors
if [ "$DISABLE_LS_COLORS" != "true" ]
then
  # Find the option for using colors in ls, depending on the version: Linux or BSD
  ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi

#setopt no_beep
setopt auto_cd
setopt multios
setopt cdablevarS

#
# grep colors
#
export GREP_OPTIONS='--color=auto'
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


#export PYTHONDONTWRITEBYTECODE=true

export PDSH_RCMD_TYPE="ssh"
export PDSH_GENDERS_FILE=`readlink -f ~/.genders`

# git-buildpackage default target.
export DIST=unstable
export ARCH=amd64

export VIRTUAL_ENV_DISABLE_PROMPT="True"

export PIP_DOWNLOAD_CACHE=~/.egg-cache

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
        source $HOME/.emacsconfig
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
E () {
    emacsclient -n -a emacs "/sudo:root@localhost:$PWD/$1"
}

if [ -f "$HOME/.zshrc.local" ]; then
    . "$HOME/.zshrc.local"
fi
