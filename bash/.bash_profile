export LC_ALL="en_US.UTF-8"

export GOPATH=$HOME/projects/go
export GOBIN=$GOPATH/bin
PATH=$GOBIN:$HOME/.bin:$HOME/.local/bin:$HOME/.rvm/bin:$HOME/.cargo/bin:/usr/local/go/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/python/libexec/bin:/usr/local/opt/postgresql@9.5/bin:/home/linuxbrew/.linuxbrew/opt/postgresql@9.6/bin:/home/linuxbrew/.linuxbrew/opt/man-db/libexec/bin:/home/linuxbrew/.linuxbrew/opt/gnu-sed/bin:$PATH
export PATH=$(n= IFS=':'; for e in $PATH; do [[ :$n == *:$e:* ]] || n+=$e:; done; echo "${n:0: -1}")

# Linuxbrew
[ -d /home/linuxbrew/.linuxbrew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

export HISTSIZE=
export HISTFILESIZE=

export EDITOR=vim
export MANPAGER=less

if [ ! -n "$SSH_CONNECTION" ]; then
    export GPG_TTY="$(tty)"
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
fi

#export LPASS_ASKPASS=lp-ap

# Aliases
if hash exa 2>/dev/null; then
    alias ll='exa -las type --group-directories-first --colour-scale'
else
    alias ll='LC_ALL=C ls -lahG --group-directories-first --color=auto'
fi

alias sbp='source $HOME/.bash_profile'
alias grep='grep --color=auto'
alias sudo='sudo '
alias vi='nvim'
alias vim='nvim'
alias ta='tmux a'
alias grbo='grb origin/$DEFAULT_BRANCH'

alias tkill='tmux kill-session -t'
alias mw='ssh mw -t tmux a'
alias dev='ssh aygcp -t /home/linuxbrew/.linuxbrew/bin/tmux a'
alias da='direnv allow'

alias pl='gco $DEFAULT_BRANCH && gpl'
alias hpr='hub pull-request'
alias lmr='lab mr create origin $DEFAULT_BRANCH -s -d'
alias kpr='ket pull-request create'
alias lis='lab issue create'
alias dcup='docker-compose up'
alias dcdown='docker-compose down'
alias sal='ssh-add -l'

# PS1
PS1="\[\e[32m\]\u@\h \[\e[34m\]\w \[\e[0m\]\j\[\e[32m\]\$\[\e[0m\] "

# direnv
hash direnv 2>/dev/null && eval "$(direnv hook bash)"

# preexec
#[ -f /home/linuxbrew/.linuxbrew/etc/profile.d/bash-preexec.sh ] && . /home/linuxbrew/.linuxbrew/etc/profile.d/bash-preexec.sh

# bash completion
brew_prefix=$(brew --prefix)
[[ -r "$brew_prefix/etc/profile.d/bash_completion.sh" ]] && . "$brew_prefix/etc/profile.d/bash_completion.sh"

# SCM Breeze
[[ -s "$HOME/.scm_breeze/scm_breeze.sh" ]] && source "$HOME/.scm_breeze/scm_breeze.sh"

# base16-shell
BASE16_SHELL=$HOME/.base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# functions
source $HOME/.bash_profile.d/functions

platform="$(tr [A-Z] [a-z] <<< `uname`)"
[[ -s "$HOME/.bash_profile.d/$platform" ]] && source "$HOME/.bash_profile.d/$platform"

# Git
export GIT_PS1_SHOWDIRTYSTATE=1
[ -n "$(type -t __git_ps1)" ] && PS1="\$(__git_ps1 [%s])$PS1"
source $HOME/.bash_profile.d/git_user

# bash completion for sudo
complete -cf sudo

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# virtualenv PS1
PS1='$(venv_ps1)'$PS1

# pyenv
hash pyenv 2>/dev/null && eval "$(pyenv init -)"

# Rust
[[ -s "$HOME/.cargo/env" ]] && source $HOME/.cargo/env
hash rustc 2>/dev/null && export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && source "/usr/local/opt/nvm/nvm.sh"
# N/A: version "N/A -> N/A" is not yet installed -> run `nvm alias default system`

# jenv
hash jenv 2>/dev/null && eval "$(jenv init -)"

# fzf
hash fzf 2>/dev/null && [ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash

# gcloud
basedir=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
path=$basedir/path.bash.inc
completion=$basedir/completion.bash.inc
[ -s $path ] && . $path
[ -s $completion ] && . $completion

[[ -z "$TMUX" ]] && tmux attach || true
