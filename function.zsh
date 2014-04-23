## exists
function exists { which $1 &> /dev/null }

## sheet
# http://blog.glidenote.com/blog/2012/04/16/sheet/
compdef _sheets sheet
function _sheets {
  local -a cmds
  _files -W  ~/.sheets/ -P '~/.sheets/'

  cmds=('list' 'edit' 'copy')
  _describe -t commands "subcommand" cmds

  return 1;
}
