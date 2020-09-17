# -*- mode: sh -*-

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable hg git bzr svn
zstyle ':vcs_info:*' actionformats '%s' ' %F{8}on %F{2}%b%F{9} doing %F{1}%a%F{5}'
zstyle ':vcs_info:*' formats '%s' ' %F{8}on %F{5}%b%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

### git: Show remote branch name for remote-tracking branches
zstyle ':vcs_info:git*+set-message:*' hooks git-remotebranch

function +vi-git-remotebranch() {
    local remote

    # Are we on a remote-tracking branch?
    remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
                   --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    # The first test will show a tracking branch whenever there is one. The
    # second test, however, will only show the remote branch's name if it
    # differs from the local one.
    if [[ -n ${remote} ]] ; then
        #if [[ -n ${remote} && ${remote#*/} != ${hook_com[branch]} ]] ; then
        hook_com[branch]="${hook_com[branch]}%F{15}->%F{5}${remote}"
    fi
}

function precmd {
    vcs_info
    case $TERM in
        *xterm*)
            print -Pn "\e]0;%n@%M: %~\a"
            ;;
    esac
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function colorise_path {
    local basename=`basename $PWD`
    local dir=`dirname $PWD`
    echo "%{$fg_bold[red]%}${dir/#$HOME/~%{$fg_bold[red]%\}}/%{$fg_bold[blue]%}$basename/%{$reset_color%}"
}

export REPORTTIME=5
TIMEFMT="'$fg[green]%J$reset_color' time: $fg[blue]%*Es$reset_color, cpu: $fg[blue]%P$reset_color"

function default_prompt {
    PROMPT='
[%(?.%{$fg[green]%}.%{$fg[red]%})%?%{$reset_color%}] %{$fg_bold[blue]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%} %F{8}in $(colorise_path)%{$reset_color%}${vcs_info_msg_1_}
$(virtualenv_info)\$ '
    RPROMPT=''
}
default_prompt

function kubernetes_prompt {
    PROMPT='
%{$fg[blue]%}Kubernetes: $ZSH_KUBECTL_PROMPT
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}${vcs_info_msg_1_}
$(virtualenv_info)$(prompt_char) '
    RPROMPT=''
}
