#!/usr/bin/env bash

export LC_ALL="en_US.UTF-8"

PLATFORM="$(tr [A-Z] [a-z] <<< `uname`)"

if hash bat 2>/dev/null; then
    alias cat='bat'
fi

if hash nvim 2>/dev/null; then
    export EDITOR=nvim
elif hash vim 2>/dev/null; then
    export EDITOR=vim
fi

export MANPAGER=less
export HISTSIZE=
export HISTFILESIZE=
export HISTCONTROL=ignoreboth

HOMEBREW_PATHS=( \
    opt/coreutils/libexec/gnubin \
    opt/findutils/libexec/gnubin \
    opt/gnu-sed/libexec/gnubin \
    opt/gnu-sed/bin \
    opt/man-db/libexec/bin \
)

# Linuxbrew
[ -d /home/linuxbrew/.linuxbrew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

# Homebrew (/usr/local)
[ -x /usr/local/bin/brew ] && eval $(/usr/local/bin/brew shellenv)

# Homebrew (/opt/homebrew)
[ -x /opt/homebrew/bin/brew ] && eval $(/opt/homebrew/bin/brew shellenv)

for path in ${HOMEBREW_PATHS[*]}; do
    abs_path=$HOMEBREW_PREFIX/$path
    if [[ -d $abs_path ]]; then
        PATH=$abs_path:$PATH
    fi
done

if [ ! -n "$SSH_CONNECTION" ]; then
    export GPG_TTY="$(tty)"
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
fi

export LPASS_ASKPASS=lp-ap

export AWS_VAULT_BACKEND=pass
export AWS_VAULT_PASS_PREFIX=aws-vault-credentials

# Aliases
if hash exa 2>/dev/null; then
    alias ll='exa -glas type --group-directories-first --colour-scale --time-style=long-iso'
else
    alias ll='LC_ALL=C ls -lahG --group-directories-first --color=auto'
fi

if hash nvim 2>/dev/null; then
    alias vi='nvim'
    alias vim='nvim'
    alias vimdiff='nvim -d'
else
    alias vi='vim'
fi

DEFAULT_BRANCH=master

OTP_STORE_DIR_NAME=.otp-store
OTP_STORE_DIR_PATH=$HOME/$OTP_STORE_DIR_NAME

alias sbp='source $HOME/.bash_profile'
alias grep='grep --color=auto'
alias sudo='sudo '
alias ta='tmux a'
alias grbo='grb origin/$DEFAULT_BRANCH'
alias grbu='grb upstream/$DEFAULT_BRANCH'
alias gcmn='git commit --amend --no-edit'

alias tkill='tmux kill-session -t'
alias da='direnv allow'

alias pl='gco $DEFAULT_BRANCH && gpl'
alias gprc='gh pr create --fill'
alias gprl='gh pr list'
alias gpru='gh pr view | grep url | awk -F "url:" "{print \$2}" | xargs'
alias gg='gcmn && gpsf'
alias lmr='lab mr create origin $DEFAULT_BRANCH -s -d'
alias lis='lab issue create'
alias dcup='docker-compose up'
alias dcdown='docker-compose down'
alias sal='ssh-add -l'
alias kc='kubectx'
alias kn='kubens'
alias watch='watch '

if hash kubecolor 2>/dev/null; then
    alias k='kubecolor'
else
    alias k='kubectl'
fi


PATH=$HOME/.bin:$HOME/.local/bin:$PATH

# PS1
if [[ "${PLATFORM}" == "darwin" ]]; then
    ps1_color=33  # yellow
else
    ps1_color=32  # green
fi

PS1="\[\e[${ps1_color}m\] \[\e[34m\]\w \[\e[${ps1_color}m\]\$\[\e[0m\] "

# direnv
if hash direnv 2>/dev/null; then
    eval "$(direnv hook bash)"
fi

# pyenv
if hash pyenv 2>/dev/null; then
    eval "$(pyenv init --path)"
fi

# jenv
if hash jenv 2>/dev/null; then
    eval "$(jenv init -)"
fi

# bash completion
if [[ -r "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh" ]]; then
    source "$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh"
fi

if [[ -d $HOME/.bash_completion.d ]]; then
    for f in $(ls $HOME/.bash_completion.d); do
        source $HOME/.bash_completion.d/$f
    done
fi

complete -cf sudo
complete -o default -F __start_kubectl k

# SCM Breeze
if [[ -s "$HOME/.scm_breeze/scm_breeze.sh" ]]; then
    source "$HOME/.scm_breeze/scm_breeze.sh"
fi

# base16-shell
BASE16_SHELL=$HOME/.base16-shell
if [[ -n "$PS1" ]] && [[ -s $BASE16_SHELL/profile_helper.sh ]]; then
    source "$BASE16_SHELL/profile_helper.sh"
fi

# Git
export GIT_PS1_SHOWDIRTYSTATE=1
if [[ -n "$(type -t __git_ps1)" ]]; then
    PS1="\$(__git_ps1 [%s])$PS1"
fi
source $HOME/.bash_profile.d/git_user

# RVM
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
    source "$HOME/.rvm/scripts/rvm"
    PATH=$HOME/.rvm/bin:$PATH
fi

# Rust
if [[ -s "$HOME/.cargo/env" ]]; then
    source $HOME/.cargo/env
fi
if hash rustc 2>/dev/null; then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi
if [[ -d $HOME/.cargo/bin ]]; then
    PATH=$HOME/.cargo/bin:$PATH
fi

# NVM
export NVM_DIR="$HOME/.nvm"
if [[ -s "/usr/local/opt/nvm/nvm.sh" ]]; then
    source "/usr/local/opt/nvm/nvm.sh"
fi
# N/A: version "N/A -> N/A" is not yet installed -> run `nvm alias default system`


# fzf
if hash fzf 2>/dev/null && [[ -f $HOME/.fzf.bash ]]; then
    source $HOME/.fzf.bash
fi

# gcloud
basedir=$HOME/.local/opt/google-cloud-sdk
path=$basedir/path.bash.inc
completion=$basedir/completion.bash.inc

if [[ -s $path ]]; then
    source $path
fi
if [[ -s $completion ]]; then
    source $completion
fi

# virtualenv PS1
venv_ps1_custom ()
{
    if [ -n "$VIRTUAL_ENV" ]; then
        echo "[p]"
    fi
}

PS1='\[\e[2m\]$(venv_ps1_custom)\[\e[0m\]'$PS1

# k8s PS1
if [[ -s "$HOMEBREW_PREFIX/opt/kube-ps1/share/kube-ps1.sh" ]]; then
    source "$HOMEBREW_PREFIX/opt/kube-ps1/share/kube-ps1.sh"

    KUBE_PS1_PREFIX="["
    KUBE_PS1_SUFFIX="]"
    KUBE_PS1_SYMBOL_ENABLE=false

    function kube_ps1_dynamically_colored() {
        if [[ "${KUBE_PS1_CONTEXT}" = *prod* ]]; then
            KUBE_PS1_PREFIX_COLOR=red
            KUBE_PS1_SUFFIX_COLOR=red
            KUBE_PS1_CTX_COLOR=red
            KUBE_PS1_NS_COLOR=red
            KUBE_PS1_DIVIDER="$(_kube_ps1_color_fg red):${KUBE_PS1_RESET_COLOR}"
            export ENV=prod
        else
            KUBE_PS1_PREFIX_COLOR=blue
            KUBE_PS1_SUFFIX_COLOR=blue
            KUBE_PS1_CTX_COLOR=blue
            KUBE_PS1_NS_COLOR=blue
            KUBE_PS1_DIVIDER="$(_kube_ps1_color_fg blue):${KUBE_PS1_RESET_COLOR}"
            export ENV=qa
        fi
        kube_ps1
    }

    PS1='$(kube_ps1_dynamically_colored)'$PS1

    export KUBE_PS1_ENABLED=off
fi

# krew
if [[ -d $HOME/.krew/bin ]]; then
    PATH=$HOME/.krew/bin:$PATH
fi

# functions
source $HOME/.bash_profile.d/functions
if [[ -s "$HOME/.bash_profile.d/$PLATFORM" ]]; then
    source "$HOME/.bash_profile.d/$PLATFORM"
fi

export PATH=$(n= IFS=':'; for e in $PATH; do [[ :$n == *:$e:* ]] || n+=$e:; done; echo "${n:0: -1}")

[[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]] && hash tmux 2>/dev/null && tmux attach || true
