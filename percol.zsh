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
    _percol_clean_prompt
}
zle -N percol_cdr
bindkey '^@' percol_cdr

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

    ppgrep $QUERY | xargs echo $*
}
