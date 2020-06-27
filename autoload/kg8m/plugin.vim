function! kg8m#plugin#init_manager(plugins_dirpath) abort  " {{{
  let plugins_path = a:plugins_dirpath
  let manager_path = expand(plugins_path . "/repos/github.com/Shougo/dein.vim")

  if !isdirectory(manager_path)
    echo "Installing plugin manager..."
    call system("git clone https://github.com/Shougo/dein.vim " . manager_path)
  endif

  let &runtimepath .= "," . manager_path

  return dein#begin(plugins_path)

  augroup my_vimrc  " {{{
    autocmd VimEnter * call s:call_hooks()
  augroup END  " }}}

  call kg8m#plugin#register(manager_path)
endfunction  " }}}

function! kg8m#plugin#finish_setup() abort  " {{{
  return dein#end()
endfunction  " }}}

function! kg8m#plugin#register(plugin_name, options = {}) abort  " {{{
  let enabled = v:true

  if has_key(a:options, "if")
    if !a:options["if"]
      " Don't load but fetch the plugin
      let a:options["rtp"] = ""
      call remove(a:options, "if")
      let enabled = v:false
    endif
  else
    " Sometimes dein doesn't add runtimepath if no options given
    let a:options["if"] = v:true
  endif

  call dein#add(a:plugin_name, a:options)
  return dein#tap(fnamemodify(a:plugin_name, ":t")) && enabled
endfunction  " }}}

function! kg8m#plugin#configure(arg, options = {}) abort  " {{{
  return dein#config(a:arg, a:options)
endfunction  " }}}

function! kg8m#plugin#get_info(plugin_name) abort  " {{{
  return dein#get(a:plugin_name)
endfunction  " }}}

function! kg8m#plugin#installable_exists(...) abort  " {{{
  if empty(a:000)
    return dein#check_install()
  else
    return dein#check_install(get(a:000, 0))
  endif
endfunction  " }}}

function! kg8m#plugin#install(...) abort  " {{{
  if empty(a:000)
    return dein#install()
  else
    return dein#install(get(a:000, 0))
  endif
endfunction  " }}}

function! kg8m#plugin#update_all() abort  " {{{
  " Remove disused plugins
  call timer_start(200, { -> map(dein#check_clean(), "delete(v:val, 'rf')") })

  call dein#update()

  let initial_input = '!Same\\ revision'
    \   . '\ !Current\\ branch\\ master\\ is\\ up\\ to\\ date.'
    \   . '\ !^$'
    \   . '\ !(*/*)\\ [+'
    \   . '\ !Created\\ autostash'
    \   . '\ !Applied\\ autostash'
    \   . '\ !HEAD\\ is\\ now'
    \   . '\ !\\ *master\\ *->\\ origin/master'
    \   . '\ !^First,\\ rewinding\\ head\\ to\\ replay\\ your\\ work\\ on\\ top\\ of\\ it'
    \   . '\ !^Fast-forwarded\\ master\\ to'
    \   . '\ !^(.*/.*)\\ From\\ '
    \   . '\ !Successfully\\ rebased\\ and\\ updated\\ refs/heads/master.'

  execute "Unite dein/log -buffer-name=update_plugins -input=" . initial_input

  " Press `n` key to search "Updated"
  let @/ = "Updated"
endfunction  " }}}

function! kg8m#plugin#is_sourced(plugin_name) abort  " {{{
  return dein#is_sourced(a:plugin_name)
endfunction  " }}}

function! s:call_hooks() abort  " {{{
  call dein#call_hook("source")
  call dein#call_hook("post_source")
endfunction  " }}}
