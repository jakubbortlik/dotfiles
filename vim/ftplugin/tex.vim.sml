" LaTeX specific settings

" mapping for opening this file in a new window
nnoremap <leader>te :vsplit ~/dotfiles/vim/ftplugin/tex.vim.sml \| setlocal nowrap<CR>

" mapping for sourcing this file
nnoremap <leader>ts :source ~/.vim/ftplugin/tex.vim<CR>

" map <leader>sh to show :Tshortcuts
nnoremap <leader>sh :Tshortcuts<CR>

"""""""""""""""""""""""""""""""""""""""""""
" Ignore some error messages from Syntastic
"""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_quiet_messages = { "regex": [
        \ '\mpossible unwanted space at "{"',
        \ '\mmissing .... before ... in ".*"',
        \ ] }

""""""""""""""""""""""""""""""""""""""""""""""
" some settings for vim-latex-suite and vimtex
""""""""""""""""""""""""""""""""""""""""""""""
" change vim-latex-suite's Tex_Leader from "`" to "+" to enable writing single
" quotes easyly in insertmode
let g:Tex_Leader = "+"

" disable vimtex imaps with "`" (mostly math symbols)
let g:vimtex_imaps_enabled = 0

" less free space in toc:
let g:vimtex_toc_secnumdepth = 1

" map the vimtex localleader
let maplocalleader = ","

" set zathura as the vimtex_view_method
let g:vimtex_view_method="mupdf"

" workaround for viewer
" nnoremap <leader>lv :silent !mupdf "%:r.pdf" &>/dev/null &<CR>

" see whether latex is working:
nnoremap <leader>la :!modcheck<CR>

" map <leader>lb to "!biber filenameWithoutExtension"
nnoremap <leader>lb :!biber "%:t:r"<CR>

" map <leader>T-> to paste \textrightarrow
call IMAP('T->', '\textrightarrow<++>', 'tex')
nmap <leader>-> aT->

" map <leader>T<- to paste \textrightarrow
call IMAP('T<-', '\textleftarrow<++>', 'tex')
nmap <leader><- aT<-

" map <leader>cit to paste \autocite[<++>]{<++>}<++> and go inside the []
call IMAP('CIP', '\autocite[<++>]{<++>}<++>', 'tex')
nmap <leader>cip aCIP

" map <leader>cip to paste \autocite[<++>]{<++>}<++> and go inside the []
call IMAP('CIT', '\textcite[<++>]{<++>}<++>', 'tex')
nmap <leader>cit aCIT

" define expansion rule for autocite (expand "autocite" after pressing F7)
let g:Tex_Com_autocite = "\\autocite[<++>]{<++>}<++>"

" define expansion rule for autocite (expand "textcite" after pressing F7)
let g:Tex_Com_textcite = "\\textcite[<++>]{<++>}<++>"

" insert \textsuperscript{}<++>
call IMAP('TS^', '\textsuperscript{<++>}<++>', 'tex')
nmap <leader>t^ aTS^

" insert \textsubscript{}<++>
call IMAP('TSV', '\textsubscript{<++>}<++>', 'tex')
nmap <leader>tv aTSV

" insert \begin{frame}<++>\end{frame}<++>
call IMAP('EFE', '\begin{frame}<++>\end{frame}<++>', 'tex')
nmap <leader>fe aEFE

" insert {\myfont<++>}<++>
call IMAP('EMF', '{\myfont<++>}<++>', 'tex')
nmap <leader>mf aEMF

" enclose one word in \alert{}
nmap <leader>al viw+al

" enclose one word in \emph{}
nmap <leader>em viw+em

""""""""""""""
" Appearance
""""""""""""""
" for faster scrolling:
setlocal lazyredraw
setlocal synmaxcol=128
syntax sync minlines=256

" Format lines to be up to 80 characters long
setlocal textwidth=80

" Set shiftwidth to 2
setlocal shiftwidth=2

" Set the tabstop to 2
setlocal tabstop=2

" in visual mode put \url{} around the selected text
vmap +ur `>a}`<i\url{

" in visual mode put \alert{} around the selected text
vmap +al `>a}`<i\alert{

" in visual mode put \uncover<++>{} around the selected text
vmap +un `>a}`<i\uncover<->{hhi

" in visual mode put \alert{} around the selected text
vmap +mf `>a}`<i{\myfont

"map <leader>cc to close the Errorwindow
nnoremap <leader>cc :ccl<CR>

" map dai to delete from the \item just before the cursor to the line just
" before the next \item
function! DeleteAllItem()
	:execute "normal! /\\($\\n\\s*\\|\\(^\\s*\\)\@<!\\\\item\\|^\\s*\\\\item\\)
				\\<CR>"
	:execute "normal! ?\\\\item\<CR>"
	:execute "normal! d/\\(^\\s*\\(\\\\end\\|\\\\begin\\){\\(enumerate\\|itemize\\|description\\|list\\|theindex\\|thebibliography\\|example\\)}\\|\\\\item\\|^?\\s*\\\\item\\)\<CR>"
endfunction
nnoremap dai :silent call DeleteAllItem()<CR><CR>

" map vai to visually select from the \item just before the cursor to the line just
" before the next \item
function! SelectAllItem()
	:execute "normal! /\\($\\n\\s*\\|\\(^\\s*\\)\@<!\\\\item\\|^\\s*\\\\item\\)
				\\<CR>"
	:execute "normal! ?\\\\item\<CR>"
	:execute "normal! v/\\n\\(\\s*\\\\item\\|\\s*\\(\\\\end\\|\\\\begin\\){\\(enumerate\\|itemize\\|description\\|list\\|theindex\\|thebibliography\\|example\\)}\\)\<CR>"
endfunction
nnoremap vai :silent call SelectAllItem()<CR><CR>

" make using the Alt+Key macros possible
let g:Tex_AdvancedMath = 1
setlocal winaltkeys=no

" ways to generate pdf files. there are soo many...
" NOTE: pdflatex generates the same output as latex. therefore quickfix is
"       possible.
let g:Tex_CompileRule_pdf = 'xelatex -interaction=nonstopmode -file-line-error-style $*'
let g:Tex_DefaultTargetFormat = 'pdf'


" This is because of vim-latex suite:
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
 
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" EXPERIMENTAL MAPPINGS
nmap yse viw+em

" vim: ft=vim
