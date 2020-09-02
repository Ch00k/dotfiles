# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/fzf/bin* ]]; then
  export PATH="$PATH:$(which fzf)"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && [ -f /usr/local/opt/fzf/shell/completion.bash ] && source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null
[[ $- == *i* ]] && [ -f /home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.bash ] && source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
[ -f /usr/local/opt/fzf/shell/key-bindings.bash ] && source "/usr/local/opt/fzf/shell/key-bindings.bash"
[ -f /home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.bash ] && source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.bash"

source $HOME/.base16-fzf/bash/base16-flat.config
