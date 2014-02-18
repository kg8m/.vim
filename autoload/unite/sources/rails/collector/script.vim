"
" gather candidates
"
function! unite#sources#rails#collector#script#candidates(source)
  let target = a:source.source__rails_root . '/script'
  return unite#sources#rails#helper#gather_candidates_file(target)
endfunction
