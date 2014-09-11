source ~/.profile

export LC_ALL="en_US.UTF-8"
export PATH=$PATH:$HOME/bin
export GOPATH=$HOME/.gopath

# virtualbox-ws
export VBOXWEB_HOST=
export VBOXWEB_USER=
export VBOXWEB_PASS=
export VBOXWEB_LOGGING=

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

# kubernetes
export KUBERNETES_PROVIDER=

# Aliases
alias cd="venv_cd"
alias ls='ls -G'
alias ll='ls -lahG'
alias sudo='sudo '
alias updatedb='/usr/libexec/locate.updatedb'

# Git prompt
source /usr/local/etc/bash_completion.d/git-prompt.sh
PS1="\$(__git_ps1 '[%s]')\[\e[01;32m\]\[\e[01;34m\] \w \[\e[1;32m\]\$\[\e[00m\] "

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PS1="\[\e[01;31m\][\$(~/.rvm/bin/rvm-prompt v g)]\[\e[00m\]$PS1"

# virtualenvwrapper
export WORKON_HOME=$HOME/v_envs
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
        gsed -i "$1d" $HOME/.ssh/known_hosts
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

# bash-completion
if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
    . $(brew --prefix)/share/bash-completion/bash_completion
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
source '/Users/ay/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
source '/Users/ay/google-cloud-sdk/completion.bash.inc'

# Bash completion for awscli
complete -C aws_completer aws
