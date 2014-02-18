"
" gather candidates
"
function! unite#sources#rails#collector#integration_test#candidates(source)
  let target = a:source.source__rails_root . '/test/integration'
  return unite#sources#rails#helper#gather_candidates_file(target)
endfunction
