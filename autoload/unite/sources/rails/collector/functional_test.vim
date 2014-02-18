"
" gather candidates
"
function! unite#sources#rails#collector#functional_test#candidates(source)
  let target = a:source.source__rails_root . '/test/functional'
  return unite#sources#rails#helper#gather_candidates_file(target)
endfunction
