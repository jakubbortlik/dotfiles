nnoremap <buffer> i i<C-r>=<sid>commit_type()<CR>

fun! s:commit_type()
  call complete(1, ['build', 'chore', 'ci', 'docs', 'feat', 'fix', 'perf', 'refactor', 'revert', 'style', 'test'])
  nunmap <buffer> i
  return ''
endfun
