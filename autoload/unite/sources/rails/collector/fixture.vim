"
" gather candidates
"
function! unite#sources#rails#collector#fixture#candidates(source)
  let target = a:source.source__rails_root . '/test/fixtures'
  return unite#sources#rails#helper#gather_candidates_file(target)
endfunction
