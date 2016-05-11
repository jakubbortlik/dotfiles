" Source a global configuration file if available
if filereadable("/etc/vimrc")
	source /etc/vimrc
endif

set nocompatible			" enable features which differ from 'vi'

if has("syntax")			" enable syntax highlighting
	syntax on
endif

set iskeyword+=$			" not sure why this is here...

"jump to the last position when reopening a file
"if has("autocmd")
"  autocmd BufReadPost *
"		\ if line("'\"") > 1 && line("'\"") <= line("$") |
"		\	exe "normal! g'\"" |
"		\ endif
"endif

"========================================
" Settings for the Vundle plugin manager:
"========================================
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'		" let Vundle manage Vundle
	Plugin 'dopefishh/vim-praat'		" syntax highlighting for praat
	Plugin 'tommcdo/vim-exchange'		" easy exange of two portions of text
	Plugin 'vim-airline/vim-airline'	" activate the vim-airline
	Plugin 'vim-airline/vim-airline-themes'	" themse for the vim-airline
	"Plugin 'unblevable/quick-scope'	" show hints for f, F, t and T commands
	Plugin 'tpope/vim-unimpaired'		" pairs of handy bracket mappings
	Plugin 'tpope/vim-fugitive'			" git wrapper
	Plugin 'tpope/vim-commentary'		" toggle comments
	Plugin 'tpope/vim-surround'			" parentheses, brackets, quotes, and more 
	Plugin 'tpope/vim-speeddating'		" let <C-A>, <C-X> work on dates properly
	"Plugin 'easymotion/vim-easymotion'	" vim motion on speed!
	"Plugin 'christoomey/vim-tmux-navigator' " navigate easily in vim and tmux

	" Colors
	Plugin 'nanotech/jellybeans.vim'
call vundle#end()

if has("autocmd")
	filetype plugin indent on		" indentation and plugins according to filetype
endif

" settings for the quick-scope plugin
" Trigger a highlight in the appropriate direction when pressing these keys:
"let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" settings for the vim-airline plugin
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='durant'
let g:airline_powerline_fonts = 1
set laststatus=2
set noshowmode " do not show mode I am currently in. HOWTO show language or insert-mode suspended through ^o?!

" Brief help for Vundle:
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

"=================
" builtin plugins:
"=================

runtime macros/matchit.vim	" matchit plugin finds matching if/endif, etc.

" jump to the next <++> placeholder in Latex-Suite. Default <c-j> conflicts
" with mapping to move between split windows
imap <C-N> <Plug>IMAP_JumpForward
nmap <C-N> <Plug>IMAP_JumpForward
vmap <C-N> <Plug>IMAP_JumpForward

"==========================================
" Put your non-Plugin stuff after this line
"==========================================


"========================
" Some useful settings:
"========================
set showcmd					" Show (partial) command in status line
set showmatch				" Show matching brackets
set ignorecase				" Do case insensitive matching
set smartcase				" Do smart case matching
set incsearch				" Incremental search
set autoindent				" Turn autoindenting on
"set cindent				" enable C style indentation
set history=500

set wildmenu				" File name completion in command mode
set wildmode=longest,full	" What to do when I press 'wildchar'. Worth tweaking.

"==========================
" some appearance settings:
"==========================
"colorscheme desert
colorscheme jellybeans
"colorscheme default

set linebreak		" define where the lines break on the screen if wrap is set
"set textwidth=80				" Set the textwidth
"set nowrap						" turn off wrapping of displayed text
set colorcolumn=81				" Display a line at the N column:
highlight ColorColumn ctermbg=52	" Set the color of the ColorColumn to "brown"
set number						" Show linenumbers
"set rnu						" Make numbers relative to position of cursor
set ruler						" show the line and column number of the cursor
set scrolloff=2					" number of screen lines above and below the cursor
set tabstop=4					" Nr of spaces a <Tab> in the file counts for  
set shiftwidth=4				" Set indentation lenght to 4 spaces, default = tabstop
set backspace=indent,eol,start	" what can you delete with backspace
set completeopt=menuone,longest,preview " list of options for i_mode completion
set hlsearch					" Use highlighting with search:
set cursorline					" the line with the cursor is underlined
set timeoutlen=2000				" time out for leader mappings
set ttimeoutlen=50				" ttime out to avoid pause when leaving i_mode
set splitbelow
set splitright

"===================================
" some language and format settings:
"===================================
set spelllang=en_us				" The default language for spell-checking
set thesaurus+=~/.vim/mthesaur.txt
set fileformat=unix				" in case I use this vimrc on a Windows machine
set encoding=utf8

"===============
" Some mappings:
"===============

let mapleader = ","
" remap two commas to perform Next search in opposite direction
nnoremap ,,	,

" These two mappings only work in gvim, not in a terminal
" insert an empty line above the current one
nnoremap <C-CR> O<Esc>
" insert an empty line below the current one
nnoremap <S-CR> o<Esc>

" keybindings for moving between split windows:
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" edit and source vimrc
nnoremap <Leader>vv :tabedit ~/.vimrc<CR>
nnoremap <Leader>vs :source ~/.vimrc<CR>

" edit and source the keymap file for Czech
nnoremap <Leader>cc :tabedit ~/comp/vim/czech_utf-8.vim<CR>
nnoremap <Leader>cs :source ~/comp/vim/czech_utf-8.vim<CR>

" language settings
nnoremap <Leader>cz :setlocal keymap=czech<CR>
nnoremap <Leader>ip :setlocal keymap=ipa<CR>
nnoremap <Leader>en :setlocal keymap=<CR>
nnoremap <Leader>ss :setlocal spell!<CR>
nnoremap <Leader>sc :setlocal spelllang=cs<CR>
nnoremap <Leader>sp :setlocal spelllang=pl<CR>
nnoremap <Leader>se :setlocal spelllang=en_us<CR>
nnoremap <Leader>sl :setlocal spelllang?<CR>

" set keymap to Czech in insert mode by pressing CRTL-^
function! KeymapWithCtrl6()
	if &iminsert == 2 || &iminsert == 0
		:setlocal keymap=czech
		:iunmap <C-^>
	else
		:iunmap <C-^>
		:let &iminsert = 0
	endif
endfunction
inoremap <C-^> <Esc>:call KeymapWithCtrl6()<CR>a

" appearance settings
nnoremap <Leader>tw :setlocal tw=79<CR>
nnoremap <Leader>t0 :setlocal tw=0<CR>
nnoremap <Leader>t4 :setlocal tabstop=4 shiftwidth=4<CR>
nnoremap <Leader>t8 :setlocal tabstop=8 shiftwidth=8<CR>

" turn off highlighting for search resutls
nnoremap <Leader>h :nohlsearch<CR>
nnoremap <Leader>w :set wrap!<CR>:echo "wrap ="&wrap<CR>
nnoremap <Leader>cl :set cursorline!<CR>

" remap Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

"copy filename to + clipboard"
nnoremap <Leader>cf :let @+=expand("%")<CR>

" save current buffer by using Ctrl-s:
nnoremap <C-S> :w<CR>
inoremap <C-S> <Esc>:w<CR>

" remap Enter to refresh underlining in split windows with aligned lines
inoremap <Enter> <CR><C-O><C-W>p<C-O><C-W>p

" remap j and k to refresh underlining in split windows with aligned lines
"nnoremap j j<C-W>p<C-W>p
"nnoremap k k<C-W>p<C-W>p

" For Emacs-style moving in Insert mode:
" to beginning of line
inoremap <C-A> <Home>
" to end of line
inoremap <C-E> <End>
" back one character
inoremap <C-B> <Left>
" forward one character
inoremap <C-F> <Right>

" For Emacs-style editing on the command-line:
" to start of line
cnoremap <C-A> <Home>
" back one character
cnoremap <C-B> <Left>
" delete character under cursor
cnoremap <C-D> <Del>
" to end of line
cnoremap <C-E> <End>
" forward one character
cnoremap <C-F> <Right>
" back one word
cnoremap <ESC>b <S-Left>
" forward one word
cnoremap <ESC>f <S-Right>
" delete word under cursor
cnoremap <ESC>d <S-Right><C-W>
" recall newer command-line
cnoremap <C-N> <Down>
" recall previous (older) command-line
cnoremap <C-P> <Up>

" abbreviations
ab h tab h
