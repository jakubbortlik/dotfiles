"3.10.1 (created: 2015/08/25 00:41:59)

source! /home/jakub/.vimperatorrc.local

" vim: set ft=vimperator:
set gui=nobookmarks,nomenu,nonavigation

let mapleader = ","
map <leader>a :set gui+=navigation<CR>
map <leader>n :set gui+=nonavigation<CR>
map <leader>t :tabduplicate<CR>
map <leader>gr :ignorekeys remove mail.google.com<CR>
map <leader>ga :ignorekeys add mail.google.com<CR>
map <leader>ma :tabmove 0<CR>
map <leader>me :tabmove<CR>
map <leader>mf :tabmove +1<CR>
map <leader>mb :tabmove -1<CR>

" vimperatorrc management
map <leader>ve :!gvim ~/.vimperatorrc<CR>
map <leader>vs :source ~/.vimperatorrc<CR>

" stop loading pages
nmap st :stop<CR>
nmap sa :stopall<CR>

" Remove search highlighting (mnemonic: Sot Option Highlighting)
nnoremap soh :noh<CR>

" Map Ctrl-ú to Esc to use for escaping on the Czech keyboard
map <C-ú> <C-[>
imap <C-ú> <C-[>
cmap <C-ú> <C-[>
" Map - to / to use for searching on the Czech keybord
map \- /
" Map _ to ? to use for backward searching on the Czech keybord
map \_ ?
" Map " to : to use for entering Command-line mode on the Czech keybord
map \" :

" Map Ctrl-M to Enter
imap <C-m> <Enter>
cmap <C-m> <Enter>

" <C-p> in Insert and Command-line mode to Previous Tab
imap <C-p> <C-[><C-p>
cmap <C-p> <up>
" <C-p> in Insert and Command-line mode to Next Tab
imap <C-n> <C-[><C-n>
cmap <C-n> <down>

" Command-line mode:
" Move one characted right
cmap <C-f> <right>
" Move one characted left
cmap <C-b> <left>
" Move one word right
cmap <A-f> <c-right>
" Move one word left
cmap <A-b> <c-left>
" Delete one character
cmap <A-d> <Del>
" Map Ctrl-Shift-v to paste from "primary selection"
cmap <C-S-v> <S-Insert>
" Disable some mappings on the commandline, otherwise they are passed to Firefox
cmap <C-j> <Enter>
cmap <C-k> <Nop>
cmap <C-r> <Nop>
cmap <C-t> <Nop>

" Insert mode:
" Move one characted right
imap <C-f> <right>
" Move one characted left
imap <C-b> <left>
" Move one word right
imap <A-f> <c-right>
" Move one word left
imap <A-b> <c-left>
" Delete one character
imap <A-d> <Del>
" Move half screen down
imap <C-d> <C-[><C-d>
" Exit Insert mode
imap <C-c> <Esc>