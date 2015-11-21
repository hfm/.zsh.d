# exists
exists() {
    which $1 1>/dev/null 2>/dev/null
}

# when using hhkb, buildin-keyboard is set to disable
disable_builtin_keyboard() {
    sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/
}

enable_builtin_keyboard() {
    sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/
}

if exists direnv; then
    eval "$(direnv hook zsh)"
fi

if exists peco; then
    source ~/.zsh.d/peco.zsh
fi

r() {
  local f
  f=(~/.zsh.d/packages/my-zsh-completions/src/*(.))
  unfunction $f:t 2> /dev/null
  autoload -U $f:t
}
