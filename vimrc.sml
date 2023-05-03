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
  if has('nvim')
    Plug 'rbong/vim-flog'                 " Git branch viewer
  endif
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
  Plug 'mechatroner/rainbow_csv'        " Show tabulated data in colour
  Plug 'chrisbra/unicode.vim'           " Work with unicode characters

  " Consider these plugins:
  Plug 'nvim-telescope/telescope.nvim'  " Gaze deeply into unknown regions using the power of the moon.
  Plug 'fannheyward/telescope-coc.nvim'
  Plug 'nvim-lua/plenary.nvim'          " required for (telescope)
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'

  " LSP support
  Plug 'williamboman/mason.nvim' " Bridge between Mason and lspconfig
  Plug 'williamboman/mason-lspconfig.nvim' " Bridge between Mason and lspconfig
  Plug 'neovim/nvim-lspconfig'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'machakann/vim-highlightedyank'  " Highlight the yanked area
  Plug 'jalvesaq/Nvim-R', { 'for': 'R' } " improved support for R code
  " Plug 'tpope/vim-flagship'           " Status line and tab line
  " Plug 'tpope/vim-flatfoot'           " Enhancement of 'f' and 't' kyes
  " Plug 'tpope/vim-obsession'          " Record sessions continuously
  Plug 'jakubbortlik/vim-psytoolkit', { 'for': 'psy' }  " Syntax highlighting for PsyToolkit scripts
  " Plug 'SirVer/ultisnips', { 'for': 'python' }
    " let g:UltiSnipsExpandTrigger="<tab>"
    " let g:UltiSnipsJumpForwardTrigger="<tab>"
    " let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
    " let g:ultisnips_python_style = 'google'
  " Plug 'honza/vim-snippets'
  Plug 'vim-scripts/FastFold'
  Plug 'tmhedberg/SimpylFold'
  Plug 'ThePrimeagen/harpoon'

  " Autocompletion
  Plug 'hrsh7th/nvim-cmp'     " Required by lsp-zero.vim
  Plug 'hrsh7th/cmp-nvim-lsp' " Required by lsp-zero.vim
  Plug 'L3MON4D3/LuaSnip'     " Required by lsp-zero.vim

  Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}

  " Colors
  Plug 'nanotech/jellybeans.vim'

  " Python plugins:
  Plug 'wookayin/semshi', { 'do': ':UpdateRemotePlugins' }  " numirias' repo " unmaintained
  Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }      " Turn VIM into a Python IDE
  Plug 'ambv/black'                     " Black code style

  " Plug 'dense-analysis/ale'           " Asynchronous Lint Engine for VIM 8 or neovim
  " let g:ale_linters = { "python": ["ruff", "pyflakes"] }
  " let g:ale_fixers = {
  " \       "python": ["black", "ruff"],
  " \}
  if has('nvim')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
  endif

  " latex plugins
  if has('nvim')
    Plug 'gerw/vim-latex-suite', { 'for': 'tex' }   " nvim alternative to official latex-suite
  endif
  Plug 'lervag/vimtex', { 'for': 'tex' }            " latex plugin with background

  " Local plugins
  " Plug '~/code/vim-phxstm', { 'for': 'phxstm' }
  " Plug '~/code/vim-keymaps'
  Plug 'https://gitlab.int.phonexia.com/bortlik/vim-dictionary', { 'for': 'dct' }
  Plug 'https://gitlab.int.phonexia.com/bortlik/vim-phxstm', { 'for': 'phxstm' }
  Plug 'https://gitlab.int.phonexia.com/bortlik/vim-srt', { 'for': 'srt' }
  Plug 'jakubbortlik/vim-keymaps'
call plug#end()

" Lightline plugin
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste', 'keymap', 'capslock' ],
      \             [ 'fugitive', 'readonly', 'myfilename', 'modified' ] ],
      \ },
      \   'mode_map': {
      \     'n': 'NORMAL', 'no': 'NORMAL', 'nov': 'NORMAL', 'noV': 'NORMAL',
      \     "no\<C-v>": 'NORMAL', 'niI': '(insert)', 'niR': '(replace)',
      \     'niV': '(vreplace)', 'nt': '(TERMINAL)', 'ntT': '(terminal)',
      \     'v': 'VISUAL', 'vs': '(visual)', 'V': 'V-LINE', 'Vs': '(visual)',
      \     "\<C-v>": 'V-BLOCK', "\<C-v>s": '(v-block)', 's': 'SELECT',
      \     'S': 'S-LINE', "\<C-s>": 'S-BLOCK', 'i': 'INSERT', 'ic': 'INSERT',
      \     'ix': 'INSERT', 'R': 'REPLACE', 'Rc': 'REPLACE', 'Rx': 'REPLACE',
      \     'Rv': 'VREPLACE', 'Rvc': 'VREPLACE', 'Rvx': 'VREPLACE',
      \     'c': 'COMMAND', 't': 'TERMINAL'
      \   },
      \ 'component_function': {
      \   'myfilename': 'LightlineFilename',
      \   'capslock': 'CapsLockStatusline',
      \   'fileencoding': 'LightlineFileencoding',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fugitive': 'LightlineFugitive',
      \   'keymap': 'LightlineKeymap',
      \   'mode': 'DetailedMode',
      \   'readonly': 'LightlineReadonly',
      \ },
      \ }

function! LightlineFilename()
  if expand('%') == ''
    return '[No Name]'
  endif
  if strlen(expand('%:t')) > 54
    return substitute(expand('%:t'), "^\\(.\\{,50}\\).*\\(.\\{4}\\)$", "\\1………\\2", "")
  endif
  return expand('%:t')
endfunc
function! LightlineFileencoding()
  let g:file_name_len = strlen(expand('%:t'))
  let g:branch_name_len = strlen(LightlineFugitive())
  return (winwidth(0) - g:file_name_len - g:branch_name_len) > 70 ? (&fileencoding !=# '' ? &fileencoding : &encoding) : ''
endfunction
function! LightlineFileformat()
  return (winwidth(0) - g:file_name_len - g:branch_name_len) > 70 ? &fileformat : ''
endfunction
function! LightlineFiletype()
  return (winwidth(0) - g:file_name_len - g:branch_name_len) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
function! DetailedMode()
  return get(g:lightline.mode_map, mode(1), get(g:lightline.mode_map, mode(), ''))
endfunction
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

" Use a more convenient leader
let mapleader = " "
let localleader = " "

" jump to the next <++> placeholder in Latex-Suite using Ctrl-Space (or <C-@>).
" Default <c-j> conflicts with custom mapping to move between split windows.
imap <C-q> <Plug>IMAP_JumpForward
nmap <C-q> <Plug>IMAP_JumpForward
vmap <C-q> <Plug>IMAP_JumpForward

" Mappings for Coc
nmap [d <Plug>(coc-diagnostic-prev)
nmap ]d <Plug>(coc-diagnostic-next)
nmap [D <Plug>(coc-diagnostic-prev-error)
nmap ]D <Plug>(coc-diagnostic-next-error)

" disable the vim-latex-suite compiler
let g:doneTexCompiler = 1

let g:tex_flavor='latex'            " start latex-suite for empty .tex files

" bashsupport mappings
let g:BASH_MapLeader  = ','         " set the leader used by bash-vim plugin

let g:semshi#error_sign_delay = 3
let g:semshi#always_update_all_highlights = 1
" let g:semshi#tolerate_syntax_errors = 1
nmap <silent> yr :Semshi rename<cr>

" only allow some lint checkers for pymode (pylama is enabled by default)
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pep257']
let g:pymode_lint_ignore = ['E501', 'D102', 'D103', 'D105', 'D107', 'D203', 'D213', 'D406', 'D407', 'D413', 'D415']
let g:pymode_preview_position = 'botright'
let g:pymode_options_max_line_length = 88
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0    " Disable rope lookup project, it causes vim to hang
let g:pymode_rope_complete_on_dot = 0   " Disable automatic completion on dot 
let g:pymode_breakpoint_cmd = 'breakpoint()'
let g:pymode_run_bind = '<leader>R'
nnoremap <leader>r :!python %
nnoremap <leader>te :!python -m unittest %<cr>
if has('nvim')
  nnoremap <leader>d :tab new term://pudb %
  nnoremap <leader>td :tab new term://python -m unittest %<cr>
else
  nnoremap <leader>d :!pudb %
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
set mouse=                  " I want normal pasting with a mouse click in a terminal
set suffixes-=.info         " Do not ignore .info files

"==========================
" some appearance settings:
"==========================
let g:jellybeans_use_term_italics = 1
let g:jellybeans_overrides = {
\    'background': { 'guibg': '000000' },
\}
let g:jellybeans_use_term_background_color = 1
colorscheme jellybeans
hi Normal ctermbg=NONE guibg=NONE               " enable pane highlighting in tmux
hi SignColumn ctermbg=NONE guibg=NONE           " enable pane highlighting in tmux
hi LineNr ctermfg=59 guifg=#605958 guibg=NONE   " enable pane highlighting in tmux
hi NonText ctermfg=240 guifg=#606060 guibg=NONE " enable pane highlighting in tmux
" hi Comment gui=NONE
hi Folded ctermfg=145 ctermbg=236 guifg=#a0a8b0 guibg=#384048 gui=NONE cterm=NONE
hi SpellBad cterm=bold ctermbg=88 gui=bold guibg=#902020 guisp=Red

if !has('nvim')
  set term=tmux-256color
endif
if &term =~ 'tmux-256color'
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
set colorcolumn=+1              " Display a line at the N column:
hi ColorColumn ctermbg=52 guibg=#700009  " Set ColorColumn to "brown"
set number                      " Show linenumbers
set relativenumber
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
let g:keymaps = ['', 'ukrainian']

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

let g:tmux_navigator_no_mappings = 1
if !has('nvim')
  execute "set <A-h>=\eh"
  execute "set <A-j>=\ej"
  execute "set <A-k>=\ek"
  execute "set <A-l>=\el"
endif
noremap <silent> <A-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <A-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <A-k> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <A-l> :<C-U>TmuxNavigateRight<cr>
noremap <silent> <A-\> :<C-U>TmuxNavigatePrevious<cr>

" Some terminal settings:
if has('nvim')
  tnoremap <A-j> <C-\><C-n><C-W>j
  tnoremap <A-k> <C-\><C-n><C-W>k
  tnoremap <A-l> <C-\><C-n><C-W>l
  tnoremap <A-h> <C-\><C-n><C-W>h

  " always enter insert mode when switching to a terminal window
  autocmd BufWinEnter,WinEnter term://* startinsert
  " always leave insert mode when switching from a terminal window
  autocmd BufWinLeave,WinLeave term://* stopinsert
  au TermOpen * setlocal listchars= nonumber
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

" Save current buffer by using Ctrl-s:
nnoremap <C-S> :update<CR>
inoremap <C-S> <Esc>:update<CR>

" Change the default grepprg to RipGrep if it's available
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
endif

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
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

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

lua << EOF
require("telescope").setup({
  extensions = {
    coc = {
        theme = 'ivy',
        prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
    }
  },
})
require('telescope').load_extension('coc')
EOF

" nnoremap <c-o> :echo "Do not use \<c-o\>!"<cr>
" nnoremap <c-i> :echo "Do not use \<c-i\>!"<cr>
" vim:set ft=vim et sw=2 sts=2 cms="%s syn=vim:
