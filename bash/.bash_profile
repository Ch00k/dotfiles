export LC_ALL="en_US.UTF-8"

export GOPATH=$HOME/projects/go
export PATH=$PATH:$GOPATH/bin:$HOME/bin:$HOME/.rvm/bin:/usr/local/go/bin

export HISTSIZE=
export HISTFILESIZE=

export SSH_AUTH_SOCK

# Aliases
alias ls='ls -G --color=auto'
alias ll='ls -lahG --color=auto'
alias grep='grep --color=auto'
alias sudo='sudo '
alias vi='vim'

alias tkill='tmux kill-session -t'
alias mw='ssh mw -t tmux a'

alias deadlib='sudo su -l -c deadlib'

# PS1
PS1="\[\e[32m\]\u@\h\[\e[34m\]\w \[\e[0m\]\j\[\e[32m\]\$\[\e[0m\] "

# SCM Breeze
[[ -s "$HOME/.scm_breeze/scm_breeze.sh" ]] && source "$HOME/.scm_breeze/scm_breeze.sh"

# base16-shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# direnv
eval "$(direnv hook bash)"

platform=`uname`
[[ -s "$HOME/.bash_profile.d/${platform,,}" ]] && source "$HOME/.bash_profile.d/${platform,,}"

# Git
export GIT_PS1_SHOWDIRTYSTATE=1
[ -n "$(type -t __git_ps1)" ] && PS1="\$(__git_ps1 [%s])$PS1"
source $HOME/.bash_profile.d/git_user

complete -cf sudo

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source $HOME/.bash_profile.d/functions

# virtualenv PS1
PS1='$(venv_ps1)'$PS1
