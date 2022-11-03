set modelines=1 " specifies the number of modelines within the file.

" General {{{
syntax on " enables syntax highlighting, and overwrites existing syntax related settings with Vim defaults.
set number " displays line numbers.
set list 
set listchars=tab:▹\ ,eol:¬ " specifies which characters to use when displaying tabs and end of line characters.
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
set cursorline " highlights the entire line of the cursor. is not activated during Visual mode.
set showmatch " jumps to matching parenthesis or bracket briefly when one is inserted.
set colorcolumn=80
set redrawtime=10000
set re=0
filetype plugin on
" set foldmethod=indent " fold lines based on indentation.
" set foldmethod=syntax " fold lines based on syntax rules.
set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()
set foldlevelstart=99
" automatically generate tags when writing the buffer.
" autocmd BufWrite * :silent !ctags -R -f .tags
" set tags +=./.tags
" }}}
" NETRW {{{
let g:netrw_liststyle = 3 " configures NETRW to use a tree-view.
let g:netrw_banner = 0 " hides the NETRW banner.
let g:netrw_browse_split = 2 " opens selected files/directories in vertical split windows.
let g:netrw_winsize = 25 " sets the horizontal window size of the NETRW window.
let g:netrw_localrmdir='rm -r' " sets the NETRW deletion command.

" automatically opens NETRW when vim is started.
" augroup ProjectDrawer
"	autocmd!
"	autocmd VimEnter * :Vexplore " When entering Vim, open the explorer (NETRW).
"	autocmd VimEnter * set wfw " When entering Vim, make the window sizes fixed.
"	autocmd VimEnter * wincmd l " When entering Vim, place curser in right buffer.
" augroup END
" }}}
" Java {{{
let java_highlight_functions="style"
autocmd FileType java set tags+=~/.vim/tags/java/8/.tags
" }}}
" Ruby {{{
" https://github.com/skwp/dotfiles/issues/802#issuecomment-427766355
let $RUBYHOME=$HOME."/.rbenv/versions/2.5.1"
set rubydll=$HOME/.rbenv/versions/2.5.1/lib/libruby.2.5.1.dylib
" }}}
" Mappings {{{
" Sets the leader key to the spacebar.
let mapleader = " "
" Surrounds the current word with quotes while in normal mode.
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
" Surrounds the current selection in visual mode with quotes.
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>`>ll
" Surrounds the current word with single quotes while in normal mode.
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
" Surrounds the current selection in visual mode with single quotes.
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>`>ll
" Opens .vimrc file for editing."
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" Reloads .vimrc file.
nnoremap <leader>sv :source $MYVIMRC<cr>
" Assings 'jk' to the Escape key when in insert mode.
inoremap jk <esc>
" Disable the arrow keys in normal mode.
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
" Based on the file type, configures the mapping for commenting a line.
autocmd filetype java nnoremap <buffer> <leader>c I//<esc>
" }}}
" Omnicompletion {{{
set omnifunc=syntaxcomplete#Complete
" }}}
" vim:foldmethod=marker:foldlevel=0
