" LaTeX specific settings

" map the localleader to use it in vimtex
let maplocalleader = ","

" Do not limit length of lines
setlocal textwidth=0
setlocal nowrap

" Set shiftwidth to 2
setlocal shiftwidth=2

" Set the tabstop to 2
setlocal tabstop=2

" make using the Alt+Key macros possible
setlocal winaltkeys=no

" search for ends of lines that do not have a comma:
nnoremap <leader>nc /\(,\)\@<!\n\($\\|@\)\@!<CR>

" Comments start with two percent signs
setlocal commentstring=%%s
