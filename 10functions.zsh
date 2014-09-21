# exists
exists() { which $1 &>/dev/null }

disable_builtin_keyboard() {
    sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/
}

enable_builtin_keyboard() {
    sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/
}
