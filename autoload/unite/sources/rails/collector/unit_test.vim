"
" gather candidates
"
function! unite#sources#rails#collector#unit_test#candidates(source)
  let target = a:source.source__rails_root . '/test/unit'
  return unite#sources#rails#helper#gather_candidates_file(target)
endfunction
