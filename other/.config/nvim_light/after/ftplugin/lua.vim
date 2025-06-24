let b:ale_linters = ['luac']
let b:ale_fixers = ['stylua']
autocmd BufWritePre <buffer> :ALEFix
