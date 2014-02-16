source ~/.profile

export LC_ALL="en_US.UTF-8"
export PATH=$PATH:$HOME/bin
export GOPATH=$HOME/.gopath

# virtualbox-ws
export VBOXWEB_HOST=
export VBOXWEB_USER=
export VBOXWEB_PASS=

# PostgreSQL
export PGDATABASE=
export PGHOST=
export PGPORT=
export PGUSER=

# Aliases
alias ll='ls -lahG'
alias updatedb='/usr/libexec/locate.updatedb'

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PS1="\[\033[01;32m\]\[\033[01;34m\] \w \$\[\033[00m\] "
PS1="\[\033[01;31m\][\$(~/.rvm/bin/rvm-prompt)]$PS1"

# virtualenvwrapper
export WORKON_HOME=$HOME/v_envs
source /usr/local/bin/virtualenvwrapper.sh

# Reboot router
rr() {
    dw_host=
    dw_username=
    dw_password=
    curl -k -X POST http://$dw_host/apply.cgi -H "Authorization: Basic $(echo -n $dw_username:$dw_password | base64)" -d "action=Reboot"
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

source $HOME/.indi_auth_user

