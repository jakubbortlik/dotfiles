local M = {
  "itchyny/lightline.vim",
}
vim.cmd [[let g:lightline = {
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
]]
return M
