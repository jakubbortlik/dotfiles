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
	Plug 'tpope/vim-commentary'	    	" toggle comments
	Plug 'tpope/vim-fugitive'			" git wrapper
	Plug 'tpope/vim-repeat'			    " repeat other plugins with . command
	Plug 'tpope/vim-rsi'				" Emulate Readline key bindings
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
	"Plug 'scrooloose/nerdtree'		" navigate through the filesystem
	"Plug 'Xuyuanp/nerdtree-git-plugin' " git status flags for NERDtree
	Plug 'christoomey/vim-tmux-navigator' " navigate easily in vim and tmux
	"
	" Consider these plugins:
	" Plug 'jalvesaq/Nvim-R'		" improved support for R code
	" Plug 'vim-scripts/UniCycle'		" replace --, ..., ', and \"
	" Plug 'tpope/vim-obsession'		" Found in airline help file
	Plug 'mechatroner/rainbow_csv'	" Show tabulated data in colour
	" Plug 'chrisbra/csv.vim'			" Another CSV plugin
	Plug 'scrooloose/syntastic'		" syntax checking
    Plug 'vim-scripts/ReplaceWithRegister' " Replace text with contents of a register

	" Colors
	Plug 'nanotech/jellybeans.vim'

	" Python plugins:
	Plug 'python-mode/python-mode', { 'for': 'python' }      " Turn VIM into a Python IDE

	" latex plugins
	" if has('nvim')
	" 	Plug 'gerw/vim-latex-suite'		" nvim alternative to official latex-suite
	" endif
	" Plug 'lervag/vimtex'				" latex plugin with background
call plug#end()

" settings for the quick-scope plugin
" Trigger a highlight in the appropriate direction when pressing these keys:
"let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" settings for the vim-airline plugin
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='durant'
let g:airline_powerline_fonts = 1
" show whether a keymap is used:
let g:airline_detect_iminsert=1
	let g:airline#extensions#tabline#show_tabs = 1
set laststatus=2				" always show the status line
set noshowmode 					" don't show mode I am in.
								" HOWTO show insert-mode suspended through ^o?!

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
" let g:pymode_lint_ignore = ["W605", "E501"]
let g:pymode_lint_checkers = ['pep8']

" set the virtual environment of anaconda
let g:pymode_virtualenv_path = '/home/bortlik/anaconda3'

" Enable autoimport
let g:pymode_rope_autoimport = 1

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
" Some useful settings:
"========================
set showcmd					" Show (partial) command in status line
set showmatch				" Show matching brackets
set ignorecase				" Do case insensitive matching
set smartcase				" Do smart case matching
set incsearch				" Incremental search
set autoindent				" Turn autoindenting on
"set cindent				" enable C style indentation
if !has('nvim')				" in neovim this is done by default
	set display=lastline	" show as much as possible of the last line in a window
	set history=10000
endif
set hidden					" leave a buffer with unsaved changes

set wildmenu				" File name completion in command mode
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
set timeoutlen=1500				" time out for leader mappings
set ttimeoutlen=50				" ttime out to avoid pause when leaving i_mode
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

" toggle NERDTree
nnoremap cot :NERDTreeToggle<CR>
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('praat', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('csv', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('xlsx', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('xls', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('txt', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
" call NERDTreeHighlightFile('pdf', 'Magenta', 'none', '#ff00ff', '#151515')

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
        :setlocal keymap=czech
	elseif &keymap == "czech"
        :setlocal keymap=
	endif
endfunction
inoremap <silent> <C-K><C-K> <Esc>:call CycleKeymapsUp()<CR>a

" " set keymap to Czech in insert mode by pressing CRTL-^
" function! KeymapWithCtrl6()
" 	if &iminsert == 2 || &iminsert == 0
" 		:setlocal keymap=czech
" 		:iunmap <C-^>
" 	else
" 		:iunmap <C-^>
" 		:let &iminsert = 0
" 	endif
" endfunction
" inoremap <C-^> <Esc>:call KeymapWithCtrl6()<CR>a

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

"copy filename to + clipboard"
nnoremap <Leader>cf :let @+=expand("%")<CR>

" save current buffer by using Ctrl-s:
nnoremap <C-S> :w<CR>
inoremap <C-S> <Esc>:w<CR>

" remap Enter to refresh underlining in split windows with aligned lines
" inoremap <Enter> <CR><C-O><C-W>p<C-O><C-W>p

" remap j and k to refresh underlining in split windows with aligned lines
" nnoremap j j<C-W>p<C-W>p
" nnoremap k k<C-W>p<C-W>p

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
" delete character under cursor - this overrides command line completion
cnoremap <C-D> <Del>
" to end of line
cnoremap <C-E> <End>
" forward one character
cnoremap <C-F> <Right>
if !has('nvim')
	" back one word
	cnoremap <ESC>b <S-Left>
	" forward one word
	cnoremap <ESC>f <S-Right>
	" delete word under cursor
	cnoremap <ESC>d <S-Right><C-W>
else
	" back one word
	cnoremap <A-b> <S-Left>
	" forward one word
	cnoremap <A-f> <S-Right>
	" delete word under cursor
	cnoremap <A-d> <S-Right><C-W>
endif
" delete from cursor position to end of line
cnoremap <C-k> <C-\>estrpart(getcmdline(),0,getcmdpos()-1)<CR>
" recall newer command-line
cnoremap <C-N> <Down>
" recall previous (older) command-line
cnoremap <C-P> <Up>

" abbreviations
" cab th tab h

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

" insert current time at cursor position
" nnoremap <leader>ct :put! =strftime('%H:%M')<CR>
nnoremap <F5> "=strftime('%H:%M')<CR>p
inoremap <F5> <C-R>=strftime('%H:%M')<CR>

" some settings for easy SMS wriging
function! ComposeSMS()
    function! ComposeSMS_startComposing()
        :echo "You are composing an SMS. tw=156 and cc=157."
        :echo "You can write just before the colour column."
        :echo "When you are finished, insert \"1/4 \", etc. in front of the text."
        :let b:ComposeSMS_old_textwidth = &l:textwidth
        :let b:ComposeSMS_old_cc = &l:colorcolumn
        :let b:ComposeSMS_old_number = &l:number
        :setlocal textwidth=156
        :setlocal cc=157
        :setlocal nonumber
        :let b:ComposeSMS_composing = 1
    endfunction
    if exists("b:ComposeSMS_composing")
        if b:ComposeSMS_composing == 1
            :echo "You have stopped composing an SMS."
            :let &l:textwidth=b:ComposeSMS_old_textwidth
            :let &l:cc=b:ComposeSMS_old_cc
            :let &l:number=b:ComposeSMS_old_number
            :let b:ComposeSMS_composing = 0
        else
            :call ComposeSMS_startComposing()
        endif
    else
        :let b:ComposeSMS_composing = 0
        :call ComposeSMS_startComposing()
    endif
endfunction

" EXPERIMENTAL SETTINGS:
" show the output of nwr (diff of nwords.txt)
nnoremap <leader>wt :!nwr<cr>
" write the diff of nwords.txt
nnoremap <leader>ww :!nwr -w<cr>
" edit the nwords.txt file
nnoremap <leader>we :e ~/skola/01_phd/02_dissertation/thesis/nwords.txt<cr>

" open the pdf for the source under cursor
function! OpenSource()
  silent execute 'normal! "zyiw'
  silent let l:source = system("sed -n '/".@z."/ p' < sources.txt")
  if l:source == ""
    echo "Reference" expand(@z) "has no file assigned."
  else
    silent execute "!awk --field-separator=: '/".@z."/ {system(\"zathura \"$2\" 2>/dev/null &\")}' sources.txt"
  endif
endfunction
nnoremap <silent> <leader>lz :call OpenSource()<CR>

" vim:set commentstring="%s:
