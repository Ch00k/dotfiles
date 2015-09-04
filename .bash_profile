source ~/.profile

export LC_ALL="en_US.UTF-8"
export PATH=$PATH:$HOME/bin:$HOME/node_modules/.bin
export GOPATH=$HOME/.gopath

export HISTSIZE=
export HISTFILESIZE=

# Homebrew
export HOMEBREW_GITHUB_API_TOKEN=

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

# Automata
export AUTOMATA_SSH_KEY=

# kubernetes
export KUBERNETES_PROVIDER=
export DOCKER_HUB_USER=

# Ansible
export ANSIBLE_HOST_KEY_CHECKING=False

#flake8
export FLAKE8_IGNORE=

# Nestor
export JENKINS_URL=

# Aliases
alias cd='venv_cd'
alias ls='ls -G --color=auto'
alias ll='ls -lahG --color=auto'
alias grep='grep --color=auto'
alias sudo='sudo '
alias vi='vim'
alias updatedb='LC_ALL=C updatedb'
alias delpyc='find . -name \*.pyc -delete'
alias nvl='nova list --name ^ay- --fields name'
alias nvd='nova delete'
alias ffmpeg='ffmpeg -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias ffplay='ffplay -hide_banner'
alias ff-frames='ffprobe -v quiet -print_format json -show_frames'

alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

# dircolors
[[ -s "$HOME/.dircolors" ]] && eval `dircolors $HOME/.dircolors`

# Git prompt
[[ -s "/usr/local/etc/bash_completion.d/git-prompt.sh" ]] && source /usr/local/etc/bash_completion.d/git-prompt.sh
PS1="\$(__git_ps1 '[%s]')\[\e[32m\]\[\e[34m\] \w \[\e[32m\]\$\[\e[00m\] "

# SCM Breeze
[[ -s "/Users/ay/.scm_breeze/scm_breeze.sh" ]] && source "/Users/ay/.scm_breeze/scm_breeze.sh"

# RVM
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

current_ruby=$(~/.rvm/bin/rvm-prompt v g)
[[ -n "$current_ruby" ]] && PS1="\[\e[35m\][\$(~/.rvm/bin/rvm-prompt v g)]\[\e[00m\]$PS1"

# virtualenvwrapper
export WORKON_HOME=$HOME/virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

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

# bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi


# Call virtualenvwrapper's "workon" if .venv exists.  This is modified from--
# http://justinlilly.com/python/virtualenv_wrapper_helper.html
# which is linked from--
# http://virtualenvwrapper.readthedocs.org/en/latest/tips.html#automatically-run-workon-when-entering-a-directory
check_virtualenv() {
    if [ -e .venv ]; then
        env=`cat .venv`
        if [ "$env" != "${VIRTUAL_ENV##*/}" ]; then
            #echo "Found .venv in directory. Calling: workon ${env}"
            workon $env
        fi
    fi
}
venv_cd () {
    builtin cd "$@" && check_virtualenv
}
# Call check_virtualenv in case opening directly into a directory (e.g
# when opening a new tab in Terminal.app).
check_virtualenv


# The next line updates PATH for the Google Cloud SDK.
# source '/Users/ay/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
# source '/Users/ay/google-cloud-sdk/completion.bash.inc'

# Bash completion for awscli
# complete -C aws_completer aws
