" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" stolen from https://github.com/mfussenegger/nvim-jdtls/discussions/124#discussioncomment-1968776
syn clear markdownLink
syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl,mkJdtLink keepend contained
syntax match mkJdtLink /jdt:\/\/.*/ containedin=markdownLink conceal
let b:current_syntax = "lsp_markdown"
