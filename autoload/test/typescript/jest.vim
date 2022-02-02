if !exists('g:test#typescript#jest#file_pattern')
  let g:test#typescript#jest#file_pattern = '\v(__tests__/.*|(spec|test))\.(ts)$'
endif

if !exists('g:test#typescript#jest#patterns')
  let g:test#typescript#patterns = g:test#javascript#patterns
endif

function! test#typescript#jest#test_file(file) abort
  let l:has_jest = test#javascript#has_package('ts-jest')
  let l:is_test_file = a:file =~# g:test#typescript#jest#file_pattern
  return (l:is_test_file)
    \ && (l:has_jest)
endfunction

function! test#typescript#jest#build_position(type, position) abort
  return test#javascript#jest#build_position(a:type, a:position)
endfunction

function! test#typescript#jest#build_args(args) abort
  return test#javascript#jest#build_args(a:args)
endfunction

function! test#typescript#jest#executable() abort
  if filereadable('node_modules/.bin/jest')
    return 'node_modules/.bin/jest'
  else
    return 'jest'
  endif
endfunction
