set modelines=1 " specifies the number of modelines within the file.

" General {{{
syntax on " enables syntax highlighting, and overwrites existing syntax related settings with Vim defaults.
set number " displays line numbers.
set list 
set listchars=tab:▹\ ,eol:¬ " specifies which characters to use when displaying tabs and end of line characters.
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
set cursorline " highlights the entire line of the cursor. is not activated during Visual mode.
set showmatch " jumps to matching parenthesis or bracket briefly when one is inserted.
" }}}
" Java {{{
let java_highlight_functions="style"
" }}}
" vim:foldmethod=marker:foldlevel=0
