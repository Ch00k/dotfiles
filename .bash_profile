source ~/.profile

export LC_ALL="en_US.UTF-8"
export PATH=$PATH:$HOME/bin:$HOME/node_modules/.bin
export GOPATH=$HOME/.gopath

export HISTSIZE=
export HISTFILESIZE=

# Homebrew
export HOMEBREW_GITHUB_API_TOKEN=

# nbviewer
GITHUB_API_TOKEN=

# virtualbox-ws
export VBOXWEB_HOST=
export VBOXWEB_USER=
export VBOXWEB_PASS=
export VBOXWEB_LOGGING=

# clapperboard
export CLPBRD_CONFIG=~/.clpbrd_config

# PostgreSQL
export PGDATABASE=
export PGHOST=
export PGPORT=
export PGUSER=

# Docker
export DOCKER_HOST=

# AWS
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_REGION=

# OpenStack
export OS_USERNAME=
export OS_PASSWORD=
export OS_TENANT_NAME=
export OS_AUTH_URL=
export OS_IMAGE_NAME=
export OS_FLAVOR_NAME=
export OS_SECURITY_GROUPS=
export OS_SSH_USER=

# Automata
export AUTOMATA_SSH_KEY=

# kubernetes
export KUBERNETES_PROVIDER=
export DOCKER_HUB_USER=

# Ansible
export ANSIBLE_HOST_KEY_CHECKING=False

# Nestor
export JENKINS_URL=

# Aliases
alias cd='venv_cd'
alias ls='ls -G --color=auto'
alias ll='ls -lahG --color=auto'
alias grep='grep --color=auto'
alias sudo='sudo '
alias vi='vim'
alias pdflatex='/Library/TeX/Root/bin/x86_64-darwin/pdflatex'
alias updatedb='LC_ALL=C updatedb'
alias nvl='nova list --name ^ay- --fields name'
alias nvd='nova delete'
alias ffmpeg='ffmpeg -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias ffplay='ffplay -hide_banner'
alias ff-frames='ffprobe -v quiet -print_format json -show_frames'

alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
alias jst='~/virtualenvs/jst/bin/python ~/projects/work/jst/jst -u $OS_USERNAME -p $OS_PASSWORD -c client'
alias dm='docker-machine'

# dircolors
[[ -s "$HOME/.dircolors" ]] && eval `dircolors $HOME/.dircolors`

# PS1
PS1="\[\e[34m\]\w \[\e[00m\]\j\[\e[32m\]\$\[\e[00m\] "

# Git prompt
export GIT_PS1_SHOWDIRTYSTATE=1
[[ -s "/usr/local/etc/bash_completion.d/git-prompt.sh" ]] && source /usr/local/etc/bash_completion.d/git-prompt.sh
if [ -n "$(type -t __git_ps1)" ]; then
    PS1="\$(__git_ps1 [%s])$PS1"
fi

# SCM Breeze
[[ -s "/Users/ay/.scm_breeze/scm_breeze.sh" ]] && source "/Users/ay/.scm_breeze/scm_breeze.sh"

# tmuxp
# TODO: Check if it exists first
source tmuxp.bash

# RVM
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if [[ -s "$HOME/.rvm/bin/rvm-prompt" ]]; then
    current_ruby=$(~/.rvm/bin/rvm-prompt v g)
fi
[[ -n "$current_ruby" ]] && PS1="\[\e[35m\][\$(~/.rvm/bin/rvm-prompt v g)]\[\e[00m\]$PS1"

# Docker machine
#[[ -s "$HOME/.dm_prompt" ]] && source "$HOME/.dm_prompt"
#if [ -n "$(type -t __docker_machine_ps1)" ]; then
#    PS1="\e[34m\$(__docker_machine_ps1 [%s])\e[00m$PS1"
#fi

# virtualenvwrapper
export WORKON_HOME=$HOME/virtualenvs
[[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && source /usr/local/bin/virtualenvwrapper.sh

# DD-WRT
DW_HOST=
DW_USERNAME=
DW_PASSWORD=
DW_COMMAND="curl -s -k -X POST http://$DW_HOST/apply.cgi -H 'Authorization: Basic $(echo -n $DW_USERNAME:$DW_PASSWORD | base64)'"

# Reboot router
rr() {
    $DW_COMMAND -d "action=Reboot" > /dev/null
}

# DHCP Renew
dr() {
    $DW_COMMAND -d "submit_button=Status_Internet&submit_type=renew&change_action=gozila_cgi&action=Apply" > /dev/null
}

# Remove entry from known_hosts
kh() {
    if [ -z "$1" ]; then
        echo "Please provide line number to remove"
    else
        sed -i "$1d" $HOME/.ssh/known_hosts
    fi
}

# Copy file contents
rem() {
    if [ -z "$1" ]; then
        echo "Please provide the file path"
    else
        cat $1 | pbcopy
    fi
}

hi() {
    history | grep "$1"
}

# Tunnell remote port to local
tunnel() {
    ssh -L $2:localhost:$2 $1 -N
}

pyclean() {
    find . -type f -name "*.py[co]" -delete
    find . -type d -name "__pycache__" -delete
}

# bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Open argument in Dash
function dash() {
    open "dash://$*"
}


# The next line updates PATH for the Google Cloud SDK.
# source '/Users/ay/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
# source '/Users/ay/google-cloud-sdk/completion.bash.inc'

# Bash completion for awscli
# complete -C aws_completer aws


# ondir
cd()
{
    builtin cd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
}

pushd()
{
    builtin pushd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
}

popd()
{
    builtin popd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
}

# Run ondir on login
eval "`ondir /`"


VPN_CONN_NAME=

vpnconnect() {
    scutil --nc start $VPN_CONN_NAME
}

vpndisconnect() {
    scutil --nc stop $VPN_CONN_NAME
}
