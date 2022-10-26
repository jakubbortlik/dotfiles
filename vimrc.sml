" Source a global configuration file if available
if filereadable('/etc/vimrc')
  source /etc/vimrc
endif

set nocompatible            " enable features which differ from 'vi'

if has('syntax')            " enable syntax highlighting
  syntax on
endif

"========================================
" Settings for the vim-plug plugin manager:
"========================================
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/bundle')
  Plug 'junegunn/vim-plug'              " get Vim help for vim-plug
  Plug 'tommcdo/vim-exchange'           " easy exange of two portions of text
  Plug 'itchyny/lightline.vim'
  Plug 'tpope/vim-capslock'             " Software capslock in insert and normal
  Plug 'tpope/vim-commentary'           " toggle comments
  Plug 'tpope/vim-fugitive'             " git wrapper
  Plug 'tpope/vim-repeat'               " repeat other plugins with . command
  Plug 'tpope/vim-rsi'                  " Emulate Readline key bindings
  Plug 'tpope/vim-scriptease'           " Vim plugin for Vim plugins
  Plug 'tpope/vim-sensible'             " 'A universal set of defaults'
  Plug 'tpope/vim-speeddating'          " let <C-A>, <C-X> work on dates properly
  Plug 'tpope/vim-surround'             " parentheses, brackets, quotes, and more 
  " Plug 'tpope/vim-tbone'              " Basic tmux support for Vim
  Plug 'tpope/vim-unimpaired'           " pairs of handy bracket mappings
  Plug 'tpope/vim-vinegar'              " Enhance netrw
  Plug 'vim-scripts/bash-support.vim'   " selfexplanatory
  Plug 'vim-scripts/VisIncr'            " in/decreasing columns of Ns and dates
  Plug 'vim-scripts/linediff.vim'       " diff two different parts of the same file
  " Plug 'ycm-core/YouCompleteMe'       " advanced code completion
  Plug 'jakubbortlik/vim-praat', { 'for': 'praat' }  " syntax highlighting for praat
  Plug 'christoomey/vim-tmux-navigator' " navigate easily in vim and tmux
  Plug 'jakubbortlik/vim-dictionary'
  Plug 'mechatroner/rainbow_csv'        " Show tabulated data in colour
  Plug 'chrisbra/unicode.vim'           " Work with unicode characters

  " Consider these plugins:
  Plug 'jalvesaq/Nvim-R'                " improved support for R code
  " Plug 'tpope/vim-flagship'           " Status line and tab line
  " Plug 'tpope/vim-flatfoot'           " Enhancement of 'f' and 't' kyes
  " Plug 'tpope/vim-obsession'          " Record sessions continuously
  " Plug 'scrooloose/syntastic'         " syntax checking
  Plug 'jakubbortlik/vim-psytoolkit', { 'for': 'psy' }  " Syntax highlighting for PsyToolkit scripts
  Plug 'SirVer/ultisnips'
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    let g:ultisnips_python_style = 'google'
  Plug 'honza/vim-snippets'
  Plug 'vim-scripts/FastFold'
  Plug 'tmhedberg/SimpylFold'

  " Colors
  Plug 'nanotech/jellybeans.vim'

  " Python plugins:
  Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
  Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }      " Turn VIM into a Python IDE
  Plug 'ambv/black'                     " Black code style
  " Plug 'dense-analysis/ale'           " Asynchronous Lint Engine for VIM 8 or neovim

  " latex plugins
  if has('nvim')
    Plug 'gerw/vim-latex-suite', { 'for': 'tex' }   " nvim alternative to official latex-suite
  endif
  Plug 'lervag/vimtex', { 'for': 'tex' }            " latex plugin with background

  " Local plugins
  Plug '~/code/vim-phxstm', { 'for': 'phxstm' }
  Plug '~/code/vim-keymaps'
call plug#end()

" Lightline plugin
let g:lightline = {
      \ 'mode_map': {
      \   'niI': '(insert)', 'niR': '(replace)', 'niV': '(virt-replace)',
      \   'ic': 'INSERT', 'ix': 'INSERT', 'Rc': 'REPLACE', 'Rv': 'VIRT-REPLACE',
      \   'Rx': 'REPLACE',
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste', 'keymap', 'capslock' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
      \ },
      \ 'component_function': {
      \   'keymap': 'LightlineKeymap',
      \   'capslock': 'CapsLockStatusline',
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \ },
      \ }

function! LightlineKeymap()
  return &keymap
endfunction
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

" jump to the next <++> placeholder in Latex-Suite using Ctrl-Space (or <C-@>).
" Default <c-j> conflicts with custom mapping to move between split windows.
imap <C-q> <Plug>IMAP_JumpForward
nmap <C-q> <Plug>IMAP_JumpForward
vmap <C-q> <Plug>IMAP_JumpForward

" disable the vim-latex-suite compiler
let g:doneTexCompiler = 1

let g:tex_flavor='latex'            " start latex-suite for empty .tex files 

" bashsupport mappings
let g:BASH_MapLeader  = ','         " set the leader used by bash-vim plugin

" don't allow automatic syntax checks for Python by Syntastic 
let g:syntastic_mode_map = {
    \ 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': ['python'] }

let g:semshi#error_sign_delay = 3
let g:semshi#always_update_all_highlights = 1
" let g:semshi#tolerate_syntax_errors = 1
nmap <silent> yr :Semshi rename<cr>

" only allow some lint checkers for pymode (pylama is enabled by default)
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_lint_ignore = ['E501']
let g:pymode_preview_position = 'botright'
let g:pymode_options_max_line_length = 88
let g:pymode_rope = 1
let g:pymode_rope_lookup_project = 0    " Disable rope lookup project, it causes vim to hang
let g:pymode_rope_complete_on_dot = 0   " Disable automatic completion on dot 
let g:pymode_breakpoint_cmd = 'breakpoint()'
let g:pymode_run_bind = '<leader>R'
nnoremap <leader>r :!python %
nnoremap <leader>te :!python -m unittest %<cr>
if has('nvim')
  nnoremap <leader>d :tab new term://pudb3 %
  nnoremap <leader>td :tab new term://python -m unittest %<cr>
else
  nnoremap <leader>d :!pudb3 %
endif
nnoremap <leader>f /breakpoint()<cr>

" prepend (^=) the ftplugins directory
set runtimepath^=~/.vim/ftplugin/

nnoremap dr :RainbowDelim<cr>

"==========================================
" Put your non-Plugin stuff after this line
"==========================================

"========================
" Some useful settings
" Other useful settings are defined in the tpope/vim-sensible plugin.
"========================
set showcmd                 " Show (partial) command in status line
set showmatch               " Show matching brackets
set ignorecase              " Do case insensitive matching
set smartcase               " Do smart case matching
if !has('nvim')             " in neovim this is done by default
  set display=lastline      " show as much as possible of the last line in a window
  set history=10000
endif
set hidden                  " leave a buffer with unsaved changes
set wildmode=longest,full   " What to do when I press 'wildchar'. Worth tweaking.
set updatetime=100

"==========================
" some appearance settings:
"==========================
let g:jellybeans_use_term_italics = 1
let g:jellybeans_overrides = {
\    'background': { 'guibg': '000000' },
\}
let g:jellybeans_use_lowcolor_black = 0
let g:jellybeans_use_term_background_color = 1
colorscheme jellybeans
" hi Normal ctermbg=NONE    " this enables pane highlighting in tmux
hi Comment cterm=NONE
hi SpellBad cterm=bold ctermbg=88 gui=bold guibg=#902020 guisp=Red

if !has('nvim')
  set term=screen-256color
endif 
if &term =~ 'screen-256color'
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

set noshowmode                  " don't show mode I am in.

set linebreak                   " define where the lines break on the screen if wrap is set
set textwidth=88                " Set the textwidth
set colorcolumn=89              " Display a line at the N column:
highlight ColorColumn ctermbg=52    " Set the color of the ColorColumn to "brown"
set number                      " Show linenumbers
set tabstop=4                   " Nr of spaces a <Tab> in the file counts for  
set shiftwidth=4                " Set indentation lenght to 4 spaces, default = tabstop
set completeopt=menuone,longest,preview " list of options for i_mode completion
set hlsearch                    " Use highlighting with search:
if has('nvim')
  set termguicolors
  set inccommand=nosplit
endif
set cursorline                  " the line with the cursor is underlined
set timeoutlen=1500             " time out for leader mappings
set splitbelow
set splitright
set nostartofline               " don't go to start of line with <CR>, <C-d>, etc.

"===================================
" some language and format settings:
"===================================
set spelllang=en_us             " The default language for spell-checking
set thesaurus+=~/.vim/mthesaur.txt
set fileformat=unix             " in case I use this vimrc on a Windows machine
if !exists('g:vim_has_started')
  set encoding=utf8
endif
let g:vim_has_started = 1
let g:keymaps = ['', 'czech', 'russian']

"===============
" Some mappings:
"===============

" Count Occurences of the last search
nnoremap co m`0:%s///gn<CR>
nnoremap cO m`:%s///gn<CR>
" greP occurences of the last search
nnoremap cp m`:g//p<CR>
nnoremap cP m`:g//p<CR>

" switch between current and last buffer
nnoremap <leader>\ <c-^>

" enable . command in visual mode
vnoremap . :normal .<cr>

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
    nnoremap <leader>tn :new term://bash<cr>
    nnoremap <leader>tv :vne term://bash<cr>
    nnoremap <leader>ti :vne term://ipython<cr>
    " tnoremap <ESC> <C-\><C-n>
endif

" Move three lines down/up instead of just one
nnoremap <C-E> 3<C-E>
nnoremap <C-Y> 3<C-Y>

" Create a new window (split vertically) and start editing an empty file in it.
nnoremap <C-W>N :vnew<CR>

" Edit vimrc in the ~/dotfiles/
nnoremap <Leader>ve :vsplit ~/dotfiles/vimrc.sml \| setlocal nowrap nobuflisted<CR>
nnoremap <Leader>vt :tabedit ~/dotfiles/vimrc.sml \| setlocal nobuflisted<CR>
" source the linked .vimrc from ~/
if has('nvim')
  nnoremap <Leader>vs :source ~/.config/nvim/init.vim<CR>
else
  nnoremap <Leader>vs :source ~/.vimrc<CR>
endif

" language settings
nnoremap <Leader>sp :setlocal spelllang=
nnoremap <Leader>sl :setlocal spelllang?<CR>
nnoremap <Leader>sc :setlocal spelllang=cs<CR>
nnoremap <Leader>se :setlocal spelllang=en_us<CR>

" Text formatting mappings
nnoremap <Leader>t0 :setlocal textwidth=0<CR>
nnoremap <Leader>t7 :setlocal textwidth=72<CR>
nnoremap <Leader>t8 :setlocal textwidth=80<CR>
nnoremap <Leader>tw :setlocal textwidth=88<CR>

" Turn off highlighting for search resutls
nnoremap yoo :nohlsearch<CR>

" Remap Space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

" Save current buffer by using Ctrl-s:
nnoremap <C-S> :update<CR>
inoremap <C-S> <Esc>:update<CR>

" Change the first occurence in a line of 'false' to 'true' and vicer versa
" Mnemonic: cv - Change Value
function! ToggleTrueFalse()
  " virtual columns ignore multibyte characters, so if there is such a
  " character in in front of the cursor, it needs to be taken care of:
  " try it here: /sʌm ˌaɪ ˌpʰiː ˈeɪ/ false
  let l:column = virtcol('.')
  let l:bytecol = col('.')
  let l:coldiff = l:bytecol - l:column
  let l:linenumber = line('.')
  let l:line = getline('.')
  let l:value_bytes = match(l:line, '\c\<\(false\|true\)\>')
  let l:value = strpart(l:line , l:value_bytes, 4)
  if l:value ==# 'fals'
    echo 'false -> true'
    silent execute "normal! :.s/\\C\\<false\\>/true/"
  elseif l:value ==# 'Fals'
    echo 'False -> True'
    silent execute "normal! :.s/\\C\\<False\\>/True/"
  elseif l:value ==# 'FALS'
    echo 'FALSE -> TRUE'
    silent execute "normal! :.s/\\C\\<FALSE\\>/TRUE/"
  elseif l:value ==# 'true'
    echo 'true -> false'
    silent execute "normal! :.s/\\C\\<true\\>/false/"
  elseif l:value ==# 'True'
    echo 'True -> False'
    silent execute "normal! :.s/\\C\\<True\\>/False/"
  elseif l:value ==# 'TRUE'
    echo 'TRUE -> FALSE'
    silent execute "normal! :.s/\\C\\<TRUE\\>/FALSE/"
  else
    echo 'No false/true value on line'
  endif
  let l:value_end = l:value_bytes + 4
  if l:value == 'true'
    if l:value_end >= l:column
      let l:offset = 0
    else
      let l:offset = 1
    endif
  elseif l:value == 'fals'
    if l:value_end >= l:column
      let l:offset = 0
    else
      let l:offset = -1
    endif
  else
    let l:offset = 0
  endif
  call cursor(l:linenumber, l:column + l:offset + l:coldiff)
endfunction
nnoremap <silent> cv :call ToggleTrueFalse()<CR>

" EXPERIMENTAL SETTINGS:
nnoremap c" :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

" Search for the ... arguments separated with whitespace (if no '!'),
" or with non-word characters (if '!' added to command).
function! SearchMultiLine(bang, ...)
  if a:0 > 0
    let sep = (a:bang) ? '\_W\+' : '\_s\+'
    let @/ = join(a:000, sep)
  endif
endfunction
command! -bang -nargs=* -complete=tag S call SearchMultiLine(<bang>0, <f-args>)|normal! /<C-R>/<CR>

command! -complete=file -nargs=+ Grr call s:RunShellCommand('grep '.<q-args>)
let stt_dir = '/home/jakub.bortlik/code/STT-ES6-3.45.5/'
let stt_bin = stt_dir.'stt '
let stt_settings = '-c '.stt_dir.'settings/stt_es_6.bs -T nbest -i '
command! -complete=file -nargs=+ Stt call s:RunShellCommand(stt_bin.stt_settings.<q-args>.' -o /tmp/tmp & cat /tmp/tmp.nbest')
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
    if part[0] =~ '\v[%#<]'
      let expanded_part = fnameescape(expand(part))
      let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
    endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  execute '0read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

" nnoremap <c-o> :echo "Do not use \<c-o\>!"<cr>
" nnoremap <c-i> :echo "Do not use \<c-i\>!"<cr>

" vim:set commentstring="%s syntax=vim:
