autoload -U compinit
compinit
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt hist_ignore_dups
setopt share_history
setopt auto_cd
setopt auto_pushd
setopt correct
setopt list_packed
setopt list_types
setopt nolistbeep

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
bindkey -e

autoload -U colors
colors
# PROMPT="%m:%n%# "
PROMPT="%{$fg[magenta]%}-> %{$reset_color%}"
RPROMPT="[%~]"
SPROMPT="%{$fg[green]%}correct?:%{$reset_color%} %R -> %r ? "

REPORTTIME=1
autoload -U promptinit
promptinit

alias gpp="clang++ -std=c++11 -Wall -O2"
alias ls="ls --color=auto"
alias l="ls"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -l -a"
alias u="cd .."
alias uu="cd ../.."
alias uuu="cd ../../.."
alias uuuu="cd ../../../.."
alias tmux="tmux -u"
alias vi="vim"
alias fing="sudo arp-scan -l -I wlp3s0 -t 1000 -r 5"

isemacs(){
    [[ "$EMACS" != "" ]] && return 0
    return 1
}

# Attache tmux
if ( ! isemacs ) && ( ! test $TMUX ) && (! expr $TERM : "linux" > /dev/null) && ( ! expr $TERM : "^screen" > /dev/null ) && which tmux > /dev/null; then
    if ( tmux has-session ); then
        session=`tmux list-sessions | grep -e '^[0-9].*]$' | head -n 1 | sed -e 's/^\([0-9]\+\).*$/\1/'`
        if [ -n "$session" ]; then
            echo "Attache tmux session $session."
            tmux attach-session -t $session
        else
            echo "Session has been already attached."
            tmux list-sessions
        fi
    else
        echo "Create new tmux session."
        tmux
    fi
fi
