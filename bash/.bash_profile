export LC_ALL="en_US.UTF-8"

export GOPATH=$HOME/.gopath
export PATH=$PATH:$GOPATH/bin:$HOME/bin

export HISTSIZE=
export HISTFILESIZE=

# Aliases
alias ls='ls -G --color=auto'
alias ll='ls -lahG --color=auto'
alias grep='grep --color=auto'
alias sudo='sudo '
alias vi='vim'

alias tkill='tmux kill-session -t'
alias mw='ssh mw -t tmux a'

# PS1
PS1="\[\e[34m\]\w \[\e[00m\]\j\[\e[32m\]\$\[\e[00m\] "

# SCM Breeze
[[ -s "$HOME/.scm_breeze/scm_breeze.sh" ]] && source "$HOME/.scm_breeze/scm_breeze.sh"

# tmuxp
eval "$(_TMUXP_COMPLETE=source tmuxp)"

# virtualenvwrapper
export WORKON_HOME=$HOME/virtualenvs
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
hash virtualenvwrapper.sh 2>/dev/null && source virtualenvwrapper.sh

# base16-shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# ondir
hash ondir 2>/dev/null && source $HOME/.bash_profile.d/ondir

platform=`uname`
[[ -s "$HOME/.bash_profile.d/${platform,,}" ]] && source "$HOME/.bash_profile.d/${platform,,}"

# Git
export GIT_PS1_SHOWDIRTYSTATE=1
[ -n "$(type -t __git_ps1)" ] && PS1="\$(__git_ps1 [%s])$PS1"
source $HOME/.bash_profile.d/git_user
