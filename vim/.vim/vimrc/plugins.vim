filetype plugin on
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle, required

if !has('ios') " Plugins that cannot load on iOS.
	" Editor plugins.
	Plugin 'vim-airline/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'
	Plugin 'tpope/vim-fugitive'
	Plugin 'ctrlpvim/ctrlp.vim'
	Plugin 'nathanaelkane/vim-indent-guides'
	Plugin 'tpope/vim-commentary'

	" Autocomplete plugins.
	Plugin 'prabirshrestha/asyncomplete.vim'
	Plugin 'prabirshrestha/async.vim'
	Plugin 'prabirshrestha/vim-lsp'
	Plugin 'prabirshrestha/asyncomplete-lsp.vim'
	Plugin 'yami-beta/asyncomplete-omni.vim'

	" JavaScript plugins.
	Plugin 'HerringtonDarkholme/yats.vim'
	Plugin 'maxmellon/vim-jsx-pretty'
	Plugin 'ryanolsonx/vim-lsp-javascript'
	Plugin 'prettier/vim-prettier'

	" Typescript plugins.
	Plugin 'runoshun/tscompletejob'
	Plugin 'prabirshrestha/asyncomplete-tscompletejob.vim' 

	" HTML plugins.
	Plugin 'alvan/vim-closetag'

	" CSS plugins.
	Plugin 'ap/vim-css-color'

	" Golang plugins.
	Plugin 'fatih/vim-go'

	" Ruby plugins.
	Plugin 'tpope/vim-endwise'
	Plugin 'tpope/vim-rails'

	" Emoji plugins.
	Plugin 'prabirshrestha/asyncomplete-emoji.vim'
endif

call vundle#end() " All of your Plugins must be added before the following line;  required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
