#  _ __   ___  ___ ___  
# | '_ \ / _ \/ __/ _ \ 
# | |_) |  __/ (_| (_) |
# | .__/ \___|\___\___/ 
# |_|                   
#
# For peco functions
# need: brew tap peco/peco; brew install peco

# ================================================
#                                                 
#   __      ___    _ __    _ __     ___    _ _    
#  / _|    / _ \  | '  \  | '  \   / _ \  | ' \   
#  \__|_   \___/  |_|_|_| |_|_|_|  \___/  |_||_|  
#_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""| 
#"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-' 
# ================================================

_peco_clean_prompt() {
    if [ -n "$TMUX" ]; then
        zle reset-prompt
    else
        zle -R -c
    fi
}

# =========================================================
#             _        _     __ _            _             
#  __ __ __  (_)    __| |   / _` |   ___    | |_     ___   
#  \ V  V /  | |   / _` |   \__, |  / -_)   |  _|   (_-<   
#   \_/\_/  _|_|_  \__,_|   |___/   \___|   _\__|   /__/_  
# _|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""| 
# "`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-' 
# =========================================================

# original: @lamanotrama
# find dirs on repository
_find_proj_root () {
    while [ $(pwd) != "$HOME" ]; do
        if [ -d .git ]; then
            pwd
            break
        fi
        cd ../
    done
}

peco_proj_cd () {
    local proj_root=$(_find_proj_root)
    local gitignore="${proj_root}/.gitignore"

    if [ -z "$proj_root" ]; then
        echo -e "\nproject root path was not found.\n" 1>&2
        _peco_clean_prompt
        return
    fi

    ignore_opt_str='-name .git'
    if [ -f "$gitignore" ]; then
        ignore_opt_str+=$(egrep -v -e '^#' -e '^ *$' "$gitignore" | perl -npe "s/^/ -o -name '/; s/\n/'/")
    fi

    local selected_dir=$(
        cd "$proj_root" &&
        echo "find . \( $ignore_opt_str \) -prune -o -maxdepth 10 -type d -print" |
          sh | peco --query "$LBUFFER"
    )

    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${proj_root}/${selected_dir#./}"
    fi
    _peco_clean_prompt
}
zle -N peco_proj_cd
bindkey '^X' peco_proj_cd

peco_select_history() {
    local tac
    exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
    output=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")

    if [ -n "$output" ]; then
        BUFFER=$output
        CURSOR=$#BUFFER
    fi

    _peco_clean_prompt
}
zle -N peco_select_history
bindkey '^R' peco_select_history

# search a destination from cdr list and cd the destination
peco_cdr() {
    local destination=$(cdr -l | awk '{print $2}' | peco --query "$LBUFFER")
    BUFFER="cd $destination"
    CURSOR=$#BUFFER
    zle accept-line
}
zle -N peco_cdr
bindkey '^@' peco_cdr

peco_src() {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N peco_src
bindkey '^S' peco_src

# =================================================================
#                                                      _           
#    __      ___    _ __    _ __    __ _    _ _     __| |    ___   
#   / _|    / _ \  | '  \  | '  \  / _` |  | ' \   / _` |   (_-<   
#   \__|_   \___/  |_|_|_| |_|_|_| \__,_|  |_||_|  \__,_|   /__/_  
# _|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""| 
# "`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-' 
# =================================================================

ppgrep() {
    if [ -z $1 ]; then
        local varpeco=peco
    else
        local varpeco="peco --query $1"
    fi
    ps aux | eval $varpeco | awk '{ print $2 }'
}

ppkill() {
    if [[ $1 =~ "^-" ]]; then
        QUERY=""
    else
        QUERY=$1
        [[ $# > 0 ]] && shift
    fi

    ppgrep $QUERY | xargs kill $*
}

ggibo() {
  if exists gibo; then
      gibo -l | peco | xargs gibo
  fi
}

prco() {
    $HOME/.dotfiles/bin/prfetch | peco | cut -f2 | xargs git checkout
}

# ag to vim
am () {
    vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}
