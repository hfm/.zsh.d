# ,------.,------. ,-----.,--.   ,--,------.,--------.
# |  .--. |  .--. '  .-.  |   `.'   |  .--. '--.  .--'
# |  '--' |  '--'.|  | |  |  |'.'|  |  '--' |  |  |
# |  | --'|  |\  \'  '-'  |  |   |  |  | --'   |  |
# `--'    `--' '--'`-----'`--'   `--`--'       `--'

autoload -U colors && colors
autoload -Uz vcs_info
function _for_prompt() {
    # set git branch-name
    # >> http://www.slideshare.net/tetutaro/zsh-20923001
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_

    # set git stash-num
    # >> http://qiita.com/items/13f85c11d3d0aa35d7ef
    git stash list &>/dev/null
    if [ $? -eq 0 ]; then
        psvar[2]=$(git stash list | wc -l | tr -d " ")
    fi
}
add-zsh-hook precmd _for_prompt

# >> http://kitak.hatenablog.jp/entry/2013/05/25/103059
zstyle ':vcs_info:*' enable git svn cvs
zstyle ':vcs_info:*' disable bzr cdv darcs mtn svk tla
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "-"
zstyle ':vcs_info:git:*' formats '%b[%c%u]'
zstyle ':vcs_info:git:*' actionformats '%b|%a[%c%u]'

PROMPT='%n@%m '
PROMPT+='%038F[%~]%f '
PROMPT+='%214F$([ -n "$TMUX" ] && tmux display -p "[#I-#P] ")%f' # >> http://yonchu.hatenablog.com/entry/20120413/1334341553
PROMPT+='%077F%2(v|(%1v @%2v) |)%f'
PROMPT+=$'\n''%B$%b '
PROMPT2='%_> '
SPROMPT='Did you mean %B%001F%r%f%b? [n,y,a,e]: '
