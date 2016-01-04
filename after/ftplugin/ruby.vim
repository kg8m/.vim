setlocal foldmethod=expr foldexpr=MyRubyFold(v:lnum)

if exists('MyRubyFold')
  finish
endif

let s:fold_start = '\C^\s*\%(class\|module\|def\|if\|unless\|when\|else\|begin\|rescue\)\>\|' .
                 \ '\<do\%(\s*|.*|\)\?\s*$\|' .
                 \ '{\%(\s*|.*|\)\?\s*$\|' .
                 \ '[\s*$'
let s:fold_end   = '\C^\s*\%(end\|}\|]\)\s*$'
let s:finish_with_end = '\C\%(\<end\|}\|]\)\s*$'

function! s:HandleIndentLevel(lnum)
  let l:indent_level = s:IndentLevel(a:lnum)

  if l:indent_level - b:indent_level >= -1
    let b:indent_level = l:indent_level
  endif
endfunction

function! MyRubyFold(lnum)
  let l:line = getline(a:lnum)

  if l:line =~ s:fold_end
    call s:HandleIndentLevel(a:lnum)
    return '<' . b:indent_level
  elseif l:line =~ s:fold_start && l:line !~ s:finish_with_end
    call s:HandleIndentLevel(a:lnum)
    return '>' . b:indent_level
  else
    return "="
  endif
endfunction

function! s:IndentLevel(lnum)
  return indent(a:lnum) / 2 + 1
endfunction

let b:indent_level = s:IndentLevel(1)
