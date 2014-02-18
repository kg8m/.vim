"
" gather candidates
"
function! unite#sources#rails#collector#environment#candidates(source)
  let target_base = a:source.source__rails_root . '/config/environment.rb'
  let target_env  = a:source.source__rails_root . '/config/environments'
  return unite#sources#rails#helper#gather_candidates_file(target_base) + unite#sources#rails#helper#gather_candidates_file(target_env)
endfunction
