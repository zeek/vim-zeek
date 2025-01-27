" Vim syntax file
" Language: Bif (https://github.com/zeek/bifcl)

if exists('b:current_syntax')
  unlet b:current_syntax
endif

" Inherit Zeek syntax
runtime! syntax/zeek.vim

" This file overrides Zeek syntax.
let s:current_syntax=b:current_syntax
unlet b:current_syntax

syntax include @bif_cpp syntax/cpp.vim
syntax region bifCppBlock matchgroup=bifCppDelim start=/%\+{/ end=/%\+}/ contains=@bif_cpp,bifTok fold
syntax match bifCppDelim /\(%(\|%)\)/ fold

" Allow `bifTok` in general `bifCppBlock`, but also explicit in `cParen`.
syntax region bifTok start="@" end="@" excludenl containedin=cParen

highlight default link bifTok Macro
highlight default link bifCppDelim Delimiter
