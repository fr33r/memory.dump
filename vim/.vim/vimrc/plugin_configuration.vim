set modelines=1 " specifies the number of modelines within the file.

" supertab {{{
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" }}}
" vim-airline {{{
" }}}
" vim-go {{{
if !has('ios')
	" configures the windows when in debug mode.
	let g:go_debug_windows = {
		\ 'vars': 'leftabove vnew',
		\ 'out': 'botright new',
		\ 'stack': 'leftabove vnew',
	\ }

	" specifies gopls for autocompletion.
	let g:go_def_mode='gopls'
	let g:go_info_mode='gopls'

	" automically show info on identifier under cursor.
	let g:go_auto_type_info = 1
endif
" }}}
" vim:foldmethod=marker:foldlevel=0
