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
alias ls='ls -G'
alias ll='ls -lahG'
alias updatedb='/usr/libexec/locate.updatedb'

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PS1="\[\e[01;32m\]\[\e[01;34m\] \w \[\e[1;32m\]\$\[\e[00m\] "
PS1="\[\e[01;31m\][\$(~/.rvm/bin/rvm-prompt)]$PS1"

# virtualenvwrapper
export WORKON_HOME=$HOME/v_envs
source /usr/local/bin/virtualenvwrapper.sh

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
