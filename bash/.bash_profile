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
hash virtualenvwrapper.sh 2>/dev/null && virtualenvwrapper.sh

# Remove entry from known_hosts
kh() {
    if [ -z "$1" ]; then
        echo "Please provide line number to remove"
    else
        sed -i "$1d" $HOME/.ssh/known_hosts
    fi
}

# Tunnell remote port to local
tunnel() {
    ssh -L $2:localhost:$2 $1 -N
}

pyclean() {
    find . -type f -name "*.py[co]" -delete
    find . -type d -name "__pycache__" -delete
}

ansclean() {
    find . -type f -name "*.retry" -delete
}

hash ondir 2>/dev/null && source $HOME/.bash_profile.d/ondir

[[ `uname` == Darwin ]] && source $HOME/.bash_profile.d/osx
