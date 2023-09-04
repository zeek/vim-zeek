if has('autocmd')
  augroup zeek
  autocmd BufNewFile,BufRead *.bro,*.zeek setfiletype zeek
endif
