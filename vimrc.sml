" Source a global configuration file if available
if filereadable("/etc/vimrc")
	source /etc/vimrc
endif

set nocompatible			" enable features which differ from 'vi'

if has("syntax")			" enable syntax highlighting
	syntax on
endif

set iskeyword+=$			" not sure why this is here...

" prepend (^=) the ftplugins directory
set runtimepath^=~/.vim/ftplugin/

"========================================
" Settings for the vim-plug plugin manager:
"========================================

call plug#begin('~/.vim/bundle')
	Plug 'junegunn/vim-plug'		" get Vim help for vim-plug
	Plug 'tommcdo/vim-exchange'		" easy exange of two portions of text
	Plug 'itchyny/lightline.vim'
	" Plug 'vim-airline/vim-airline'	" activate the vim-airline
	" Plug 'vim-airline/vim-airline-themes'	" themse for the vim-airline
	Plug 'tpope/vim-capslock'			" Software capslock in insert and normal
	Plug 'tpope/vim-commentary'			" toggle comments
	Plug 'tpope/vim-fugitive'			" git wrapper
	Plug 'tpope/vim-repeat'			    " repeat other plugins with . command
	Plug 'tpope/vim-rsi'				" Emulate Readline key bindings
	Plug 'tpope/vim-scriptease'			" Vim plugin for Vim plugins
	Plug 'tpope/vim-sensible'			" 'A universal set of defaults'
	Plug 'tpope/vim-speeddating'		" let <C-A>, <C-X> work on dates properly
	Plug 'tpope/vim-surround'			" parentheses, brackets, quotes, and more 
	Plug 'tpope/vim-tbone'			    " Basic tmux support for Vim
	Plug 'tpope/vim-unimpaired'	        " pairs of handy bracket mappings
	Plug 'tpope/vim-vinegar'			" Enhance netrw
	Plug 'vim-scripts/bash-support.vim' " selfexplanatory
	Plug 'vim-scripts/VisIncr'		" in/decreasing columns of Ns and dates
	Plug 'jakubbortlik/vim-keymaps'	" use custom keymaps for Czech and IPA
	" Plug 'ycm-core/YouCompleteMe'    " advanced code completion
	" Plug 'jakubbortlik/vim-praat'	" syntax highlighting for praat
	Plug 'christoomey/vim-tmux-navigator' " navigate easily in vim and tmux
	"
	" Consider these plugins:
	" Plug 'jalvesaq/Nvim-R'		" improved support for R code
	" Plug 'vim-scripts/UniCycle'		" replace --, ..., ', and \"
	" Plug 'tpope/vim-flagship'			" Status line and tab line
	" Plug 'tpope/vim-flatfoot'			" Enhancement of 'f' and 't' kyes
	" Plug 'tpope/vim-obsession'		" Record sessions continuously
	Plug 'mechatroner/rainbow_csv'	" Show tabulated data in colour
	" Plug 'chrisbra/csv.vim'			" Another CSV plugin
	Plug 'scrooloose/syntastic'		" syntax checking
    Plug 'vim-scripts/ReplaceWithRegister' " Replace text with contents of a register
    Plug 'chrisbra/unicode.vim'         " Work with unicode characters
    Plug 'terryma/vim-smooth-scroll'    " Smooth scrolling

	" Colors
	Plug 'nanotech/jellybeans.vim'

	" Python plugins:
	Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }      " Turn VIM into a Python IDE

	" latex plugins
	" if has('nvim')
	" 	Plug 'gerw/vim-latex-suite'		" nvim alternative to official latex-suite
	" endif
	" Plug 'lervag/vimtex'				" latex plugin with background
call plug#end()

set laststatus=2				" always show the status line
set noshowmode 					" don't show mode I am in.
								" HOWTO show insert-mode suspended through ^o?!

" Lightline plugin
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'myfilename': 'LightlineFilename',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

function! LightlineReadonly()
	return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
	if exists('*FugitiveHead')
		let branch = FugitiveHead()
		return branch !=# '' ? ''.branch : ''
	endif
	return ''
endfunction
function! LightlineFilename()
	return (LightlineReadonly() !=# '' ? LightlineReadonly() . ' ' : '') .
		  \ (&ft ==# 'vimfiler' ? vimfiler#get_status_string() :
		  \  &ft ==# 'unite' ? unite#get_status_string() :
		  \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]') .
		  \ (LightlineModified() !=# '' ? ' ' . LightlineModified() : '')
endfunction
function! LightlineModified()
	return &modifiable && &modified ? '+' : ''
endfunction

" jump to the next <++> placeholder in Latex-Suite using Ctrl-Space (or <C-@>).
" Default <c-j> conflicts with custom mapping to move between split windows.
imap <C-Space> <Plug>IMAP_JumpForward
nmap <C-Space> <Plug>IMAP_JumpForward
vmap <C-Space> <Plug>IMAP_JumpForward

" disable the vim-latex-suite compiler
let g:doneTexCompiler = 1

let g:tex_flavor='latex'            " start latex-suite for empty .tex files 

" bashsupport mappings
let g:BASH_MapLeader  = ','         " set the leader used by bash-vim plugin

" don't allow automatic syntax checks for Python by Syntastic 
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": [],
    \ "passive_filetypes": ["python"] }

" only allow some lint checkers for pymode (pylama is enabled by default, but it
" does not recognize f-strings
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_lint_ignore = ["W605", "E501"]
let g:pymode_lint_checkers = ['pep8']

" Enable autoimport
let g:pymode_rope_autoimport = 1

" Set breakpoint command (does not work in Python 3.5)
let g:pymode_breakpoint_cmd = 'breakpoint()'
let g:pymode_run_bind = '<leader>R'
" Run current file with python with ,r
nnoremap ,r :!python %<cr>

"=================
" builtin plugins:
"=================

runtime macros/matchit.vim	" matchit plugin finds matching if/endif, etc.

" prepend (^=) the ftplugins directory
set runtimepath^=~/.vim/ftplugin/

"==========================================
" Put your non-Plugin stuff after this line
"==========================================


"========================
" Some useful settings
" Other useful settings are defined in the tpope/vim-sensible plugin.
"========================
set showcmd					" Show (partial) command in status line
set showmatch				" Show matching brackets
set ignorecase				" Do case insensitive matching
set smartcase				" Do smart case matching
if !has('nvim')				" in neovim this is done by default
	set display=lastline	" show as much as possible of the last line in a window
	set history=10000
endif
set hidden					" leave a buffer with unsaved changes
set wildmode=longest,full	" What to do when I press 'wildchar'. Worth tweaking.

"==========================
" some appearance settings:
"==========================
let g:jellybeans_use_term_italics = 1
" let g:jellybeans_overrides = {
" \    'background': { 'guibg': '000000' },
" \}
" let g:jellybeans_use_lowcolor_black = 0
let g:jellybeans_use_term_background_color = 1
colorscheme jellybeans
" hi Normal ctermbg=NONE		" this enables pane highlighting in tmux
hi Comment cterm=NONE

if !has('nvim')
  set term=screen-256color
endif 
if &term =~ "screen-256color"
  " 256 colors
  let &t_Co = 256
  " restore screen after quitting
  let &t_ti = "\<Esc>7\<Esc>[r\<Esc>[?47h"
  let &t_te = "\<Esc>[?47l\<Esc>8"
  if has("terminfo")
    let &t_Sf = "\<Esc>[3%p1%dm"
    let &t_Sb = "\<Esc>[4%p1%dm"
  else
    let &t_Sf = "\<Esc>[3%dm"
    let &t_Sb = "\<Esc>[4%dm"
  endif
endif

set linebreak		" define where the lines break on the screen if wrap is set
set textwidth=80				" Set the textwidth
set colorcolumn=81				" Display a line at the N column:
highlight ColorColumn ctermbg=52	" Set the color of the ColorColumn to "brown"
set number						" Show linenumbers
set tabstop=4					" Nr of spaces a <Tab> in the file counts for  
set shiftwidth=4				" Set indentation lenght to 4 spaces, default = tabstop
set completeopt=menuone,longest,preview " list of options for i_mode completion
set hlsearch					" Use highlighting with search:
set cursorline					" the line with the cursor is underlined
set timeoutlen=1500				" time out for leader mappings
set splitbelow
set splitright
set nostartofline				" don't go to start of line with <CR>, <C-d>, etc.

"===================================
" some language and format settings:
"===================================
set spelllang=en_us				" The default language for spell-checking
set thesaurus+=~/.vim/mthesaur.txt
set fileformat=unix				" in case I use this vimrc on a Windows machine
if !exists("g:vim_has_started")
	set encoding=utf8
endif
let g:vim_has_started = 1

"===============
" Some mappings:
"===============

let mapleader = ","
" remap two commas to perform Next search in opposite direction
nnoremap ,,	,

" show the number of occurences of the last search
nnoremap <leader>n :%s///gn<CR>
" show all lines containing the last search
nnoremap <leader>g :g//p<CR>

" switch between current and last buffer
nnoremap <leader>. <c-^>

" enable . command in visual mode
vnoremap . :normal .<cr>

" keybindings for moving between split windows:
" nnoremap <C-J> <C-W>j
" nnoremap <C-K> <C-W>k
" nnoremap <C-L> <C-W>l
" nnoremap <C-H> <C-W>h
" nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
" Some terminal settings:
if has('nvim')
	tnoremap <C-J> <C-\><C-n><C-W>j
	tnoremap <C-K> <C-\><C-n><C-W>k
	tnoremap <C-L> <C-\><C-n><C-W>l
	tnoremap <C-H> <C-\><C-n><C-W>h
	" nnoremap <BS> <C-W>h
	nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

	" always enter insert mode when switching to a terminal window
	autocmd BufWinEnter,WinEnter term://* startinsert
	" always leave insert mode when switching from a terminal window
	autocmd BufWinLeave,WinLeave term://* stopinsert
    tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
    nnoremap <leader>te :new term://bash<cr>
    nnoremap <leader>tt :vne term://bash<cr>
    " tnoremap <ESC> <C-\><C-n>
endif

nnoremap <C-E> 3<C-E>
nnoremap <C-Y> 3<C-Y>

" edit vimrc in the ~/dotfiles/
nnoremap <Leader>ve :vsplit ~/dotfiles/vimrc.sml \| setlocal nowrap<CR>
nnoremap <Leader>vt :tabedit ~/dotfiles/vimrc.sml<CR>
" source the linked .vimrc from ~/
if has('nvim')
	nnoremap <Leader>vs :source ~/.config/nvim/init.vim<CR>
else
	nnoremap <Leader>vs :source ~/.vimrc<CR>
endif

" edit and source the keymap file for Czech
nnoremap <Leader>cc :tabedit ~/.vim/bundle/vim-keymaps/keymap/czech_utf-8.vim<CR>
nnoremap <Leader>cs :source ~/.vim/bundle/vim-keymaps/keymap/czech_utf-8.vim<CR>

" open a Git status window
nnoremap gs :Gstatus<CR>

" language settings
nnoremap <Leader>cz :setlocal keymap=czech<CR>
nnoremap <Leader>ip :setlocal keymap=ipa<CR>
nnoremap <Leader>en :setlocal keymap=<CR>
nnoremap <Leader>ru :setlocal keymap=russian-jcukenwin<CR>
nnoremap <Leader>scs :setlocal spelllang=cs<CR>
nnoremap <Leader>spl :setlocal spelllang=pl<CR>
nnoremap <Leader>sen :setlocal spelllang=en_us<CR>
nnoremap <Leader>sl :setlocal spelllang?<CR>

" cycle through keymaps: English -> Czech -> IPA in insert mode by pressing
" <C-K><C-J> and <C-K><C-K>
function! CycleKeymapsDown()
	if &keymap == ""
		:setlocal keymap=czech
	elseif &keymap == "czech"
		:setlocal keymap=russian-jcukenwin
	elseif &keymap == "russian-jcukenwin"
        :setlocal keymap=ipa
	elseif &keymap == "ipa"
        :setlocal keymap=
	endif
endfunction
inoremap <silent> <C-K><C-J> <Esc>:call CycleKeymapsDown()<CR>a
function! CycleKeymapsUp()
	if &keymap == ""
		:setlocal keymap=ipa
	elseif &keymap == "ipa"
		:setlocal keymap=russian-jcukenwin
	elseif &keymap == "russian-jcukenwin"
        :setlocal keymap=czech
	elseif &keymap == "czech"
        :setlocal keymap=
	endif
endfunction
inoremap <silent> <C-K><C-K> <Esc>:call CycleKeymapsUp()<CR>a

" text formatting settings
nnoremap <Leader>tw :setlocal textwidth=80<CR>
nnoremap <Leader>t7 :setlocal textwidth=75<CR>
nnoremap <Leader>t0 :setlocal textwidth=0<CR>
nnoremap <Leader>t4 :setlocal tabstop=4 shiftwidth=4<CR>
nnoremap <Leader>t8 :setlocal tabstop=8 shiftwidth=8<CR>
nnoremap <Leader>q gwip

" turn off highlighting for search resutls
nnoremap coh :nohlsearch<CR>

" remap Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" save current buffer by using Ctrl-s:
nnoremap <C-S> :w<CR>
inoremap <C-S> <Esc>:w<CR>

" change the last word in a line from "false" to "true" and vicer versa
" Mnemonic: cv - Change Value
function! ToggleTrueFalse()
    " virtual columns ignore multibyte characters, so if there is such a
    " character in in front of the cursor, it needs to be taken care of:
    " try it here: /sʌm ˌaɪ ˌpʰiː ˈeɪ/ false
	let column = virtcol(".")
    let bytecol = col(".")
    let coldiff = bytecol - column
	let linenumber = line(".")
	let line = getline(".")
    let value_bytes = match(line, '\c\<\(false\|true\)\>')
	let value = strpart(line , value_bytes, 4)
	if value ==# "fals"
        echo "false -> true"
		silent execute "normal! :.s/\\Cfalse/true/"
	elseif value ==# "Fals"
        echo "False -> True"
		silent execute "normal! :.s/\\CFalse/True/"
	elseif value ==# "FALS"
        echo "FALSE -> TRUE"
		silent execute "normal! :.s/\\CFALSE/TRUE/"
	elseif value ==# "true"
        echo "true -> false"
		silent execute "normal! :.s/\\Ctrue/false/"
	elseif value ==# "True"
        echo "True -> False"
		silent execute "normal! :.s/\\CTrue/False/"
	elseif value ==# "TRUE"
        echo "TRUE -> FALSE"
		silent execute "normal! :.s/\\CTRUE/FALSE/"
	else
        echo "No false/true value on line"
	endif
    let value_end = value_bytes + 4
    if value == "true"
        if value_end >= column
            let offset = 0
        else
            let offset = 1
        endif
    elseif value == "fals"
        if value_end >= column
            let offset = 0
        else
            let offset = -1
        endif
    else
        let offset = 0
    endif
    call cursor(linenumber, column + offset + coldiff)
endfunction
nnoremap <silent> cv :call ToggleTrueFalse()<CR>

" EXPERIMENTAL SETTINGS:
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" vim:set commentstring="%s syntax=vim:
