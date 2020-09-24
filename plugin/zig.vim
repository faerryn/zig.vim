if exists("g:zig_loaded")
  finish
endif
let g:zig_loaded = 1

function! s:fmt_autosave()
  if get(g:, "zig_fmt_autosave", 1)
    call zig#fmt#Format()
  endif
endfunction

function! s:enable_include_search()
  if get(g:, "zig_include_search", 1)
    if has('find_in_path')
      let &l:includeexpr = 'substitute(v:fname, "^([^.])$", "\1.zig", "")'
      let &l:include = '\v(\@import>|\@cInclude>|^\s*\#\s*include)'
    else
      setlocal include&
      setlocal includeexpr&
    endif
  endif
endfunction

augroup vim-zig
  autocmd!
  autocmd BufWritePre *.zig call s:fmt_autosave()
  autocmd FileType zig call s:enable_include_search()
augroup end

" vim: sw=2 ts=2 et
