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

function prompt_char {
    case ${vcs_info_msg_0_} in
        git)
            echo '±';;
        hg)
            echo 'Hg';;
        "")
            echo "\$";;
        *)
            echo "${vcs_info_msg_0_} \$";;
    esac
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function chruby_info {
    [ $RUBY_ROOT ] && echo '('`basename $RUBY_ROOT`') '
}

function colorise_path {
    local basename=`basename $PWD`
    local dir=`dirname $PWD`
    echo "%{$fg_bold[red]%}${dir/#$HOME\//%{$fg_bold[grey]%\}~/%{$fg_bold[red]%\}}/%{$fg[white]%}$basename/%{$reset_color%}"
}

export REPORTTIME=5
TIMEFMT="'$fg[green]%J$reset_color' time: $fg[blue]%*Es$reset_color, cpu: $fg[blue]%P$reset_color"

function default_prompt {
    PROMPT='
%{$fg_bold[blue]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%} %F{8}in $(colorise_path)%{$reset_color%}${vcs_info_msg_1_}
$(chruby_info)$(virtualenv_info)$(prompt_char) '
    RPROMPT='[%(?.%{$fg[green]%}.%{$fg[red]%})%?%{$reset_color%}]'
}
default_prompt

function openstack_url_type {
    OS_PORT=$(echo $OS_AUTH_URL | awk 'BEGIN { FS = "[:/]" } { print $5 }')
    case $OS_PORT in
        35357)
            echo "admin"
            ;;
        5000)
            echo "public"
            ;;
        *)
            echo "unknown"
            ;;
    esac

}

function openstack_cloud {
    OS_HOSTNAME=$(echo $OS_AUTH_URL | awk 'BEGIN { FS = "[:/]" } { print $4 }')
    case $OS_HOSTNAME in
        *dev*)
            echo "dev"
            ;;
        *test*)
            echo "test"
            ;;
        *)
            echo "prod"
            ;;
    esac
}

function openstack_keystone {
    OS_HOSTNAME=$(echo $OS_AUTH_URL | awk 'BEGIN { FS = "[.:/]" } { print $4 }')
    echo $OS_HOSTNAME
}

function openstack_prompt {
    PROMPT='
☁  %{$fg[magenta]%}${OS_USERNAME}%{$reset_color%}@%{$fg[yellow]%}${OS_TENANT_NAME}%{$reset_color%} %{$fg_bold[green]%}$(openstack_keystone).$(openstack_cloud):$(openstack_url_type)%{$reset_color%}/%{$fg[yellow]%}${OS_REGION_NAME}%{$reset_color%}
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}${vcs_info_msg_1_}
$(virtualenv_info)$(prompt_char) '
}

function kubernetes_prompt {
    PROMPT='
%{$fg[blue]%}Kubernetes: $ZSH_KUBECTL_PROMPT
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}${vcs_info_msg_1_}
$(chruby_info)$(virtualenv_info)$(prompt_char) '
    RPROMPT=''
}
