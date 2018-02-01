" R specific settings

" map the localleader to use it in R files
let maplocalleader = ","

" map <localleader>H to show the header of the item under cursor
nmap <silent> <LocalLeader>H :call RAction("head")<CR>
