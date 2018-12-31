set modelines=1 " specifies the number of modelines within the file.

" General {{{
syntax on " enables syntax highlighting, and overwrites existing syntax related settings with Vim defaults.
set number " displays line numbers.
set list 
set listchars=tab:▹\ ,eol:¬ " specifies which characters to use when displaying tabs and end of line characters.
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
set cursorline " highlights the entire line of the cursor. is not activated during Visual mode.
set showmatch " jumps to matching parenthesis or bracket briefly when one is inserted.
filetype plugin on
" }}}
" NETRW {{{
let g:netrw_liststyle = 3 " configures NETRW to use a tree-view.
let g:netrw_banner = 0 " hides the NETRW banner.
let g:netrw_browse_split = 2 " opens selected files/directories in vertical split windows.
let g:netrw_winsize = 25 " sets the horizontal window size of the NETRW window.
let g:netrw_localrmdir='rm -r' " sets the NETRW deletion command.

" automatically opens NETRW when vim is started.
augroup ProjectDrawer
	autocmd!
	autocmd VimEnter * :Vexplore
augroup END
" }}}
" Java {{{
let java_highlight_functions="style"
" }}}
" vim:foldmethod=marker:foldlevel=0
