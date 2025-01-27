" Vim syntax file
" Language: Zeek (https://zeek.org)
" Author: Jon Siwek

if exists('b:current_syntax')
  finish
endif

" For highlighting payloads to `@TEST-EXEC*`.
syntax include @zeekSh syntax/sh.vim

syn match zeekComment /#.*/ contains=zeekTodo
syn keyword zeekTodo TODO XXX FIXME NOTE contained

syntax match zeekBTest /\v\@TEST(-\w+)+:?.*/ containedin=zeekComment containedin=ALL " This group only resets syntax.
syntax region zeekBTestExec start=/@TEST-\(EXEC\|REQUIRES\).\{-}\s/ end=/$/ containedin=zeekBTest contains=@zeekSh
syntax match zeekBTestKeyword /@TEST-.\{-}\s/ containedin=zeekBTestExec containedin=zeekBTestOther
" Extra case for keywords which do not take args or no shell commands.
syntax match zeekBTestKeyword /@TEST-\(DOC\|END-FILE\|GROUP\|IGNORE\|KNOWN-FAILURE\|MEASURE-TIME\|PORT\|START-FILE\|START-NEXT\)/ containedin=zeekBTest

syn match zeekDirective /\v\@(DEBUG|DIR|FILENAME)/
syn match zeekDirective /\v\@(deprecated)/
syn match zeekDirective /\v\@pragma(\s+[^[:space:]]+)?\s*/ nextgroup=zeekDirectiveArg
syn match zeekDirective /\v\@(ifdef|ifndef|else|endif|if)/
syn match zeekDirective /\v\@prefixes\s*\+?\=\s*/ nextgroup=zeekDirectiveArg
syn match zeekDirective /\v\@(load-plugin|load-sigs|load|unload)\s+/ nextgroup=zeekDirectiveArg
syn match zeekDirectiveArg /\v[^ #]*/ contained

syn region zeekString matchgroup=zeekSeparator start=/"/ skip=/\\"/ end=/"/ contains=zeekEscapeChar,zeekFmtSpec
syn region zeekPattern matchgroup=zeekSeparator start=/\v\/(.*\/)@=/ skip=/\\\// end=/\// contains=zeekEscapeChar
syn match zeekEscapeChar /\\./ contained
syn match zeekFmtSpec /\v\%\-?\d*(\.\d+)?[DTdxsefg]/ contained

syn keyword zeekModule module nextgroup=zeekModuleID skipwhite
syn match zeekModuleID /\v<([A-Za-z_][A-Za-z_0-9]*)(::[A-Za-z_][A-Za-z_0-9]*)*>/ contained

syn match zeekCall /\v<([A-Za-z_][A-Za-z_0-9]*)(::[A-Za-z_][A-Za-z_0-9]*)*>(\s*\()@=/

syn keyword zeekExport export

syn keyword zeekAssert assert
syn keyword zeekRedef redef
syn keyword zeekPrint print
syn keyword zeekCopy copy
syn keyword zeekAsync when timeout schedule
syn keyword zeekConditional if else switch
syn keyword zeekLoop for while
syn keyword zeekControlFlow return break next continue fallthrough
syn keyword zeekLabel case default

syn keyword zeekBool T F
syn match zeekInt /\v<\d+>/
syn match zeekInt /\v<0x[0-9a-fA-F]+>/
syn match zeekPort /\v<\d{1,5}>\/<(udp|tcp|icmp|unknown)>/

syn match zeekFloat /\v<((\d+\.\d*)|(\d*\.\d+))([eE][+-]?\d+)?>/
syn match zeekFloat /\v<(\d+)([eE][+-]?\d+)>/

syn match zeekInterval /\v<((\d+)|(\d+\.\d*)|(\d*\.\d+))([eE][+-]?\d+)?\s*(day|hr|min|msec|usec|sec)s?>/

syn match zeekHost /\v[A-Za-z0-9][A-Za-z0-9\-]*(\.[A-Za-z0-9][A-Za-z0-9\-]*)+/
syn match zeekAddr /\v(25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[0-9]{1,2})\.(25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[0-9]{1,2})\.(25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[0-9]{1,2})\.(25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[0-9]{1,2})/
" This IPv6 regex may not be 100% correct.  The real deal takes some effort.
syn match zeekAddr /\v\[([0-9a-fA-F]{0,4}:){2,7}([0-9a-fA-F]{0,4})((25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[0-9]{1,2})\.(25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[0-9]{1,2})\.(25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[0-9]{1,2})\.(25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[0-9]{1,2}))?\]/

syn keyword zeekTypeDef type

syn keyword zeekType any
syn keyword zeekType connection
syn keyword zeekType enum record set table vector
syn keyword zeekType addr bool count double file int interval pattern port
syn keyword zeekType string subnet time
syn keyword zeekType function hook event

syn keyword zeekTypeMod global local const option

syn keyword zeekType opaque nextgroup=zeekOpaqueOf skipwhite
syn keyword zeekOpaqueOf of nextgroup=zeekOpaqueID skipwhite contained
syn match zeekOpaqueID /\v<([A-Za-z_][A-Za-z_0-9]*)(::[A-Za-z_][A-Za-z_0-9]*)*>/ contained

syn keyword zeekOperatorWord in as is of
syn keyword zeekTableOp add delete

syn match zeekOperator /\v\>/
syn match zeekOperator /\v\</
syn match zeekOperator /\v\!/
syn match zeekOperator /\v\=/
syn match zeekOperator /\v\+/
syn match zeekOperator /\v\-/
syn match zeekOperator /\v\*/
syn match zeekOperator /\v\/(.*\/)@!/
syn match zeekOperator /\v\%/
syn match zeekOperator /\v\&/
syn match zeekOperator /\v\|/
syn match zeekOperator /\v\^/
syn match zeekOperator /\v\~/
syn match zeekOperator /\v\?/
syn match zeekOperator /\v\:/

syn match zeekOperator /\v\+\+/
syn match zeekOperator /\v\-\-/

syn match zeekOperator /\v\+\=/
syn match zeekOperator /\v\-\=/
syn match zeekOperator /\v\>\=/
syn match zeekOperator /\v\<\=/
syn match zeekOperator /\v\!\=/
syn match zeekOperator /\v\=\=/

syn match zeekOperator /\v\&\&/
syn match zeekOperator /\v\|\|/

syn match zeekOperator /\v\$/
syn match zeekOperator /\v\?\$/

syn match zeekAttribute /\v\&<(redef|priority|log|optional|ordered|default|default_insert|add_func|delete_func|expire_func|read_expire|write_expire|create_expire|synchronized|persistent|rotate_interval|rotate_size|encrypt|raw_output|mergeable|error_handler|type_column|deprecated|on_change|backend|broker_store|broker_allow_complex_type|is_assigned|is_used|group)>/

highlight default link zeekTodo    Todo
highlight default link zeekComment Comment
highlight default link zeekDirective PreProc
highlight default link zeekDirectiveArg Underlined

highlight default link zeekBTestKeyword SpecialComment
highlight default link zeekBTestOther SpecialComment

highlight default link zeekString String
highlight default link zeekPattern String
highlight default link zeekSeparator Delimiter
highlight default link zeekEscapeChar SpecialChar
highlight default link zeekFmtSpec Special

highlight default link zeekType Type
highlight default link zeekTypeDef Typedef
highlight default link zeekTypeMod StorageClass
highlight default link zeekAttribute StorageClass

highlight default link zeekBool Boolean
highlight default link zeekInt Number
highlight default link zeekFloat Float
highlight default link zeekAddr Constant
highlight default link zeekHost Constant
highlight default link zeekPort Constant
highlight default link zeekInterval Constant

highlight default link zeekOperator Operator
highlight default link zeekOpaqueOf Keyword
highlight default link zeekOperatorWord Keyword
highlight default link zeekTableOp Keyword

highlight default link zeekID Identifier
highlight default link zeekModuleID Identifier
highlight default link zeekOpaqueID Type
highlight default link zeekCall Identifier

highlight default link zeekConditional Conditional
highlight default link zeekControlFlow Keyword
highlight default link zeekLoop Repeat
highlight default link zeekLabel Label

highlight default link zeekModule Keyword
highlight default link zeekAssert Keyword
highlight default link zeekRedef Keyword
highlight default link zeekExport Keyword
highlight default link zeekPrint Keyword
highlight default link zeekCopy Keyword
highlight default link zeekAsync Keyword
highlight default link zeekKeyword Keyword

" TODO Could add Structure group to enum/record (re)definitions

let b:current_syntax = 'zeek'
