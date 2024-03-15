" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

runtime! syntax/log.vim
let b:current_syntax = "dapui_console"

" Java highlight groups
" NOTE: maybe highlight groups can be combined?
syn match javaLogPackage '\(\([a-zA-Z_$][a-zA-Z0-9_$]*\.\)\+[a-zA-Z_$][a-zA-Z0-9_$]*\)\s*'
syn match javaLogException '\(\([a-zA-Z_$][a-zA-Z0-9_$]*\.\)\+[a-zA-Z_$][a-zA-Z0-9_$]*\)\s*Exception'
hi def link javaLogPackage Conditional
hi def link javaLogException ErrorMsg
