hi clear
syntax reset
let g:colors_name = "marrissa-only"
set background=dark
set t_Co=256
hi Normal guifg=#dadada ctermbg=NONE guibg=#020003 gui=NONE

hi DiffText guifg=#616097 guibg=NONE
hi ErrorMsg guifg=#616097 guibg=NONE
hi WarningMsg guifg=#616097 guibg=NONE
hi PreProc guifg=#616097 guibg=NONE
hi Exception guifg=#616097 guibg=NONE
hi Error guifg=#616097 guibg=NONE
hi DiffDelete guifg=#616097 guibg=NONE
hi GitGutterDelete guifg=#616097 guibg=NONE
hi GitGutterChangeDelete guifg=#616097 guibg=NONE
hi cssIdentifier guifg=#616097 guibg=NONE
hi cssImportant guifg=#616097 guibg=NONE
hi Type guifg=#616097 guibg=NONE
hi Identifier guifg=#616097 guibg=NONE
hi PMenuSel guifg=#a47daa guibg=NONE
hi Constant guifg=#a47daa guibg=NONE
hi Repeat guifg=#a47daa guibg=NONE
hi DiffAdd guifg=#a47daa guibg=NONE
hi GitGutterAdd guifg=#a47daa guibg=NONE
hi cssIncludeKeyword guifg=#a47daa guibg=NONE
hi Keyword guifg=#ff56d2 guibg=NONE
"hi IncSearch guifg=#828a7b guibg=NONE
hi link IncSearch Visual
hi Title guifg=#828a7b guibg=NONE
hi PreCondit guifg=#828a7b guibg=NONE
hi Debug guifg=#828a7b guibg=NONE
hi SpecialChar guifg=#828a7b guibg=NONE
hi Conditional guifg=#828a7b guibg=NONE
hi Todo guifg=#828a7b guibg=NONE
hi Special guifg=#828a7b guibg=NONE
hi Label guifg=#828a7b guibg=NONE
hi Delimiter guifg=#828a7b guibg=NONE
hi Number guifg=#828a7b guibg=NONE
hi CursorLineNR guifg=#828a7b guibg=NONE
hi Define guifg=#828a7b guibg=NONE
hi MoreMsg guifg=#828a7b guibg=NONE
hi Tag guifg=#828a7b guibg=NONE
hi String guifg=#355b47 guibg=NONE
hi MatchParen guifg=#828a7b guibg=NONE
hi Macro guifg=#828a7b guibg=NONE
hi DiffChange guifg=#828a7b guibg=NONE
hi GitGutterChange guifg=#828a7b guibg=NONE
hi cssColor guifg=#828a7b guibg=NONE
hi Function guifg=#823f8f guibg=NONE
hi Directory guifg=#76507e guibg=NONE
hi markdownLinkText guifg=#76507e guibg=NONE
hi javaScriptBoolean guifg=#76507e guibg=NONE
hi Include guifg=#76507e guibg=NONE
hi Storage guifg=#76507e guibg=NONE
hi cssClassName guifg=#76507e guibg=NONE
hi cssClassNameDot guifg=#76507e guibg=NONE
hi Statement guifg=#f5d6fc guibg=NONE
hi Operator guifg=#f5d6fc guibg=NONE
hi cssAttr guifg=#f5d6fc guibg=NONE


hi Pmenu guifg=#dadada guibg=#130114
hi SignColumn guibg=#020003
hi Title guifg=#dadada
hi LineNr guifg=#747474 guibg=#020003
hi NonText guifg=#928a92 guibg=#020003
hi Comment guifg=#928a92 gui=italic
hi SpecialComment guifg=#928a92 gui=italic guibg=NONE
hi CursorLine guibg=#130114
hi TabLineFill gui=NONE guibg=#130114
hi TabLine guifg=#747474 guibg=#130114 gui=NONE
hi StatusLine gui=bold guibg=#130114 guifg=#dadada
hi StatusLineNC gui=NONE guibg=#020003 guifg=#dadada
hi Search guibg=#928a92 guifg=#dadada
hi VertSplit gui=NONE guifg=#130114 guibg=NONE
hi Visual gui=NONE guifg=#130114 guibg=#828a7b

" markdown treesitter stuff
hi @markup.heading.1.markdown gui=bold guibg=#f5d6fc guifg=#130114
hi @markup.heading.2.markdown gui=bold guibg=#616097 guifg=#130114
hi @markup.heading.3.markdown gui=bold guibg=#823f8f guifg=#130114
hi @markup.heading.4.markdown gui=bold guibg=#828a7b guifg=#130114
hi @markup.heading.5.markdown gui=bold guibg=#76507e guifg=#130114
hi @markup.heading.6.markdown gui=bold guibg=#928a92 guifg=#130114

