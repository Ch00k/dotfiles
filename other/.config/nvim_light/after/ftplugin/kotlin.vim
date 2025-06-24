set textwidth=120
set colorcolumn=120

let b:ale_linters = ['ktlint']
let b:ale_fixers = ['ktlint']
let g:ale_kotlin_ktlint_options="-l none"

autocmd BufWritePre <buffer> :ALEFix
