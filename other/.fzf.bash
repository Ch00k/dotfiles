# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.bash"

# Base16 Flat
# Author: Chris Kempson (http://chriskempson.com)

_gen_fzf_default_opts() {

local color00='#2C3E50'
local color01='#34495E'
local color02='#7F8C8D'
local color03='#95A5A6'
local color04='#BDC3C7'
local color05='#e0e0e0'
local color06='#f5f5f5'
local color07='#ECF0F1'
local color08='#E74C3C'
local color09='#E67E22'
local color0A='#F1C40F'
local color0B='#2ECC71'
local color0C='#1ABC9C'
local color0D='#3498DB'
local color0E='#9B59B6'
local color0F='#be643c'

export FZF_DEFAULT_OPTS="
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
  --history=$HOME/.bash_history
"

}

_gen_fzf_default_opts
