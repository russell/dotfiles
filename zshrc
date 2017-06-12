# -*- mode: sh -*-
ZSHDIR=$HOME/.zsh
source $ZSHDIR/antigen.zsh
fpath=($ZSHDIR/completion $fpath)

# Detect OSX
DARWIN=false
if [[ $(uname) == "Darwin" ]]; then
  DARWIN=true;
fi

antigen-bundle zsh-users/zsh-syntax-highlighting
antigen-bundle zsh-users/zsh-completions
gfpath=(~/.antigen/repos/https-COLON--SLASH--SLASH-github.com-SLASH-zsh-users-SLASH-zsh-completions.git $fpath)

antigen-bundle robbyrussell/oh-my-zsh plugins/git
antigen-bundle robbyrussell/oh-my-zsh plugins/debian
antigen-bundle robbyrussell/oh-my-zsh plugins/pip
antigen-bundle robbyrussell/oh-my-zsh plugins/virtualenvwrapper
antigen-bundle robbyrussell/oh-my-zsh plugins/chruby
antigen-apply

# Load syntax highlighting if it's installed
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Disable underline of paths
ZSH_HIGHLIGHT_STYLES[path]='none'

# Set up the prompt
if [[ $TERM == "dumb" ]]; then	# in emacs
    PS1='%(?..[%?])%!:%~%# '
    # for tramp to not hang, need the following. cf:
    # http://www.emacswiki.org/emacs/TrampMode
    unsetopt zle
    unsetopt prompt_cr
    setopt prompt_subst
    source ~/.zsh/emacs.zsh-theme
else
    setopt prompt_subst
    autoload -U colors
    colors
    source ~/.zsh/arrsim.zsh-theme
fi

autoload -U add-zsh-hook


#
# Aliases
#
alias zshconfig="source ~/.zshrc"

setopt appendhistory histignorealldups sharehistory autocd extendedglob dvorak

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
bindkey '\ew' kill-region
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
if $DARWIN; then
    eval "$(gdircolors -b)"
else
    eval "$(dircolors -b)"
fi
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

function rehash-hosts {
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
}

rehash-hosts

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher irc \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios list proxy libuuid\
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs rtkit \
        statd usbmux saned speech-dispatcher hplip dovenull Debian-exim \
        Debian-gdm colord bitlbee backup cl-builder dnsmasq gnats man \
        messagebus sys memcache mongodb mpd puppet puppetdb uuidd nagios \
        _graphite stunnel4

# ... unless we really want to.
zstyle '*' single-ignored show


# make deleting part of a dns entry easier.
WORDCHARS=''

NOVA_DIR=/usr/local/src/python-novaclient
if [ -e $NOVA_DIR ]; then
    autoload -U bashcompinit;bashcompinit;source $NOVA_DIR/tools/nova.bash_completion
fi

if [ -f ~/.zaliases ]; then
    . ~/.zaliases
fi

#
# ls colors
#
autoload colors; colors;

#setopt no_beep
setopt auto_cd
setopt multios
setopt cdablevarS

if [[ "$COLORTERM" == "gnome-terminal" ]]
then
    TERM=xterm-256color
fi

if command -v direnv > /dev/null; then
    eval "$(direnv hook zsh)"
fi


#export PYTHONDONTWRITEBYTECODE=true

# Openstack RC Files
osrc() { source ~/.os/$1; }
compdef "_path_files -f -W ~/.os/" osrc

# Virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT="True"

if [ -n "$SSH_CONNECTION" ]
then

    _IP=$(echo -n $SSH_CONNECTION | cut -d\  -f3)
    _RHOSTNAME=$(host $_IP 2>/dev/null | sed -n 's/.*pointer \(.*\)[.]/\1/p')
    _HOSTIP=$(hostname -i 2>/dev/null)

    if [[ "$_IP" == "$_HOSTIP" ]]; then
        _HOST=$(hostname -f 2>/dev/null)
    elif [ -n "$_RHOSTNAME" ]; then
        _HOST="$_RHOSTNAME"
    else
        _HOST="$_IP"
    fi

else
    _HOST=$(hostname -f 2>/dev/null)
fi

function eterm-precmd {
    echo -e "\033AnSiTu" "$LOGNAME"
    echo -e "\033AnSiTh" "$_HOST"
    echo -e "\033AnSiTc" "$(pwd)"
    echo -e "\033AnSiTp" "$(basename $SHELL)"
}

function eterm-preexec {
    echo -e "\033AnSiTp" $(echo "$1" | cut -d ' ' -f 1)
}

# Track directory, username, and cwd for remote logons.
if [ "$TERM" = "eterm-color" ]; then
    add-zsh-hook precmd eterm-precmd
    add-zsh-hook preexec eterm-preexec
fi

function openstack_clear {
    if [ -n "$(env | awk -F '=' '/OS_/ { print $1 }')" ]; then
       unset $(env | awk -F '=' '/OS_/ { print $1 }')
    fi
    default_prompt
}

if [ -f /usr/local/opt/chruby/share/chruby/auto.sh ]; then
    source /usr/local/opt/chruby/share/chruby/auto.sh
fi

if [ -f "$HOME/.zshrc.local" ]; then
    . "$HOME/.zshrc.local"
fi
# BEGIN DOCKER-IMAGES
source /Users/rsim/zendesk/docker-images/dockmaster/zdi.sh
# END DOCKER-IMAGES
