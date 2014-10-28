setlocal foldmethod=expr foldexpr=MyRubyFold(v:lnum)

if exists('MyRubyFold')
  finish
endif

let s:fold_start = '^\s*\%(class\|module\|def\)\>\|' .
                 \ '\<do\%(\s|.*|\)\?\s*$'
let s:fold_end   = '^\s*end\s*$'
let s:finish_with_end = '\<end\s*$'

function! MyRubyFold(lnum)
  let l:line = getline(a:lnum)

  if l:line =~ s:fold_end
    return '<' . s:IndentLevel(a:lnum)
  elseif l:line =~ s:fold_start && l:line !~ s:finish_with_end
    return '>' . s:IndentLevel(a:lnum)
  else
    return "="
  endif
endfunction

function! s:IndentLevel(lnum)
  return indent(a:lnum) / 2 + 1
endfunction
