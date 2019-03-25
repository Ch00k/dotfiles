export LC_ALL="en_US.UTF-8"

export GOPATH=$HOME/projects/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$HOME/.bin:$HOME/.local/bin:$HOME/.rvm/bin:$HOME/.cargo/bin:/usr/local/go/bin:/usr/local/bin:/usr/local/sbin:$PATH

export HISTSIZE=
export HISTFILESIZE=

#eval `ssh-agent`
export SSH_AUTH_SOCK

# Aliases
if hash exa 2>/dev/null; then
    alias ll='exa -las type --group-directories-first --colour-scale'
else
    alias ll='LC_ALL=C ls -lahG --group-directories-first --color=auto'
fi

alias grep='grep --color=auto'
alias sudo='sudo '
alias vi='vim'
alias ta='tmux a'

alias tkill='tmux kill-session -t'
alias mw='ssh mw -t tmux a'
alias da='direnv allow'

alias m='gco master && gpl'
alias hpr='hub pull-request'
alias lmr='lab mr create'
alias lis='lab issue create'
alias dcup='docker-compose up'
alias dcdown='docker-compose down'

# PS1
PS1="\[\e[32m\]\u@\h \[\e[34m\]\w \[\e[0m\]\j\[\e[32m\]\$\[\e[0m\] "

# SCM Breeze
[[ -s "$HOME/.scm_breeze/scm_breeze.sh" ]] && source "$HOME/.scm_breeze/scm_breeze.sh"

# base16-shell
BASE16_SHELL=$HOME/.base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# direnv
hash direnv 2>/dev/null && eval "$(direnv hook bash)"

# functions
source $HOME/.bash_profile.d/functions

# platform specific stuff
platform=`uname`
[[ -s "$HOME/.bash_profile.d/${platform,,}" ]] && source "$HOME/.bash_profile.d/${platform,,}"

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
[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash

# gcloud
basedir=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
path=$basedir/path.bash.inc
completion=$basedir/completion.bash.inc
[ -s $path ] && . $path
[ -s $completion ] && . $completion
