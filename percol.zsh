#  ________  _______   ________  ________  ________  ___          
# |\   __  \|\  ___ \ |\   __  \|\   ____\|\   __  \|\  \         
# \ \  \|\  \ \   __/|\ \  \|\  \ \  \___|\ \  \|\  \ \  \        
#  \ \   ____\ \  \_|/_\ \   _  _\ \  \    \ \  \\\  \ \  \       
#   \ \  \___|\ \  \_|\ \ \  \\  \\ \  \____\ \  \\\  \ \  \____  
#    \ \__\    \ \_______\ \__\\ _\\ \_______\ \_______\ \_______\
#     \|__|     \|_______|\|__|\|__|\|_______|\|_______|\|_______|
#
# For percol functions
# need: `pip install percol --allow-external percol --allow-unverified percol`

# ================================================
#                                                 
#   __      ___    _ __    _ __     ___    _ _    
#  / _|    / _ \  | '  \  | '  \   / _ \  | ' \   
#  \__|_   \___/  |_|_|_| |_|_|_|  \___/  |_||_|  
#_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""| 
#"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-' 
# ================================================

_percol_clean_prompt() {
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

percol_proj_cd () {
    local proj_root=$(_find_proj_root)
    local gitignore="${proj_root}/.gitignore"

    if [ -z "$proj_root" ]; then
        echo -e "\nproject root path was not found.\n" 1>&2
        _percol_clean_prompt
        return
    fi

    ignore_opt_str='-name .git'
    if [ -f "$gitignore" ]; then
        ignore_opt_str+=$(egrep -v -e '^#' -e '^ *$' "$gitignore" | perl -npe "s/^/ -o -name '/; s/\n/'/")
    fi

    local selected_dir=$(
        cd "$proj_root" &&
        echo "find . \( $ignore_opt_str \) -prune -o -maxdepth 10 -type d -print" |
          sh | percol --query "$LBUFFER"
    )

    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${proj_root}/${selected_dir#./}"
    fi
    _percol_clean_prompt
}
zle -N percol_proj_cd
bindkey '^X' percol_proj_cd

percol_select_history() {
    local tac
    exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
    output=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")

    if [ -n "$output" ]; then
        BUFFER=$output
        CURSOR=$#BUFFER
    fi

    _percol_clean_prompt
}
zle -N percol_select_history
bindkey '^R' percol_select_history

# search a destination from cdr list and cd the destination
percol_cdr() {
    local destination=$(cdr -l | awk '{print $2}' | percol --query "$LBUFFER")
    BUFFER="cd $destination"
    CURSOR=$#BUFFER
    zle accept-line
}
zle -N percol_cdr
bindkey '^@' percol_cdr

percol_src() {
    local selected_dir=$(ghq list --full-path | percol --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N percol_src
bindkey '^S' percol_src

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
        PERCOL=percol
    else
        PERCOL="percol --query $1"
    fi
    ps aux | eval $PERCOL | awk '{ print $2 }'
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
      gibo -l | percol | xargs gibo
  fi
}

prco() {
    $HOME/.dotfiles/bin/prfetch | percol | cut -f2 | xargs git checkout
}
