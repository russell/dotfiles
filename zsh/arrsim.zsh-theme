# -*- mode: sh -*-

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable hg git bzr svn
zstyle ':vcs_info:*' actionformats '%s' ' on  %F{2}%b%F{9} doing %F{1}%a%F{5}'
zstyle ':vcs_info:*' formats '%s' ' on %F{5}%b%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
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

# local time, color coded by last return code
time_enabled="%(?.%{$fg[green]%}.%{$fg[red]%})%*%{$reset_color%}"
time_disabled="%{$fg[green]%}%*%{$reset_color%}"
time=$time_enabled

PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}${PWD/#$HOME/~}%{$reset_color%}${vcs_info_msg_1_}
$(virtualenv_info)$(prompt_char) '
RPROMPT=''
