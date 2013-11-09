#!/bin/sh

if [ ! -e $HOME/.zsh.d ]; then
  ln -sF $HOME/.dotfiles/myzsh/zsh.d  $HOME/.zsh.d
fi

if [ ! -e $HOME/.zlogin ]; then
cat <<'EOF' > $HOME/.zlogin
echo "Hello, Z World !"

EOF
fi

cat <<'EOF' > $HOME/.zshenv
source ~/.zsh.d/zshenv
EOF

cat <<'EOF' > $HOME/.zshrc
source ~/.zsh.d/zshrc
source ~/.zsh.d/aliases.zsh
source ~/.zsh.d/theme.zsh
source ~/.zsh.d/config/packages.zsh
EOF

ls -hal ~/.zsh{.d,env,rc} ~/.zlogin

cat <<'EOF'

,--.                       
,-|  | ,---. ,--,--,  ,---.  
' .-. || .-. ||      \| .-. : 
\ `-' |' '-' '|  ||  |\   --. 
`---'  `---' `--''--' `----' 

EOF
