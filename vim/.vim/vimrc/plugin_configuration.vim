set modelines=1 " specifies the number of modelines within the file.

" supertab 
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
" 
" vim-airline 
" 
" vim-go 
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
" 
" asyncomplete 
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

" Sets up the client for the Golang language server.
" https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Go
" NOTE: requires that gopls is installed on your machine.
if executable('gopls')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'gopls',
		\ 'cmd': {server_info->['gopls']},
		\ 'whitelist': ['go'],
	\ })
endif

" Sets up the client for the HTML language server.
" https://github.com/prabirshrestha/vim-lsp/wiki/Servers-HTML
" NOTE: requires that VSCode HTML language server is installed on your machine.
if executable('html-languageserver')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'html-languageserver',
		\ 'cmd': {server_info->[&shell, &shellcmdflag, 'html-languageserver --stdio']},                                   
		\ 'whitelist': ['html'],
	\ })
endif

" Sets up the client for the Ruby language server.
" https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Ruby
" NOTE: requires the SolarGraph language server is installed on your machine.
if executable('solargraph')
	" gem install solargraph
	au User lsp_setup call lsp#register_server({
		\ 'name': 'solargraph',
		\ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
		\ 'whitelist': ['ruby'],
	\ })
endif

if executable('typescript-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
        \ 'whitelist': ['typescript', 'typescript.tsx', 'typescriptreact'],
        \ })
endif

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
\ 'name': 'omni',
\ 'whitelist': ['*'],
\ 'completor': function('asyncomplete#sources#omni#completor')
\  }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#emoji#get_source_options({
\ 'name': 'emoji',
\ 'allowlist': ['*'],
\ 'completor': function('asyncomplete#sources#emoji#completor'),
\ }))

let g:lsp_log_verbose = 0
let g:lsp_log_file = ''
let g:lsp_diagnostics_highlights_delay = 150
let g:lsp_diagnostics_signs_delay = 10
let g:lsp_completion_resolve_timeout = 20
let g:lsp_document_code_action_signs_delay = 50
let g:lsp_preview_autoclose = 0
let g:asyncomplete_auto_completeopt = 0

set completeopt=menuone,noinsert,noselect,preview
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" for asyncomplete.vim log
let g:asyncomplete_log_file = expand('~/asyncomplete.log')
" 
" vim-closetag 
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx,js'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }
" 
"  CTRL-P 
if executable('rg')
	let g:ctrlp_user_command = 'rg %s --files --hidden --glob ""'
end
" 
" vim:foldmethod=marker:foldlevel=0
