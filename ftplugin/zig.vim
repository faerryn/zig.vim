" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

let s:cpo_orig = &cpo
set cpo&vim

" Recomended code style, no tabs and 4-space indentation
setlocal expandtab
setlocal tabstop=8
setlocal softtabstop=4
setlocal shiftwidth=4

setlocal formatoptions-=t formatoptions+=croql

setlocal suffixesadd=.zig,.zir
setlocal makeprg=zig\ build

if has('comments')
    setlocal comments=:///,://!,://,:\\\\
    setlocal commentstring=//\ %s
endif

let &l:define='\v(<fn>|<const>|<var>|^\s*\#\s*define)'

if exists("*json_decode") && executable('zig')
    silent let s:env = system('zig env')
    if v:shell_error == 0
        let &l:path=json_decode(s:env)['std_dir'] . ',' . &l:path
    endif
    unlet! s:env
endif

let b:undo_ftplugin =
    \ 'setl et< ts< sts< sw< fo< sua< mp< com< cms< inex< inc< pa<'

let &cpo = s:cpo_orig
unlet s:cpo_orig
" vim: tabstop=8 shiftwidth=4 softtabstop=4 expandtab
