" Author: Aryeh Leib Taurog <git@aryehleib.com>
" Description: pgsanity for PostgreSQL sql files

function! ale_linters#sql#pgsanity#Handle(buffer, lines) abort
    " Matches patterns like the following:
    "
    " line 30: ERROR: syntax error at or near ";"
    let l:pattern = '\v^\w+\s+(\d+):([^:]+):\s+(.*)'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \   'lnum': l:match[1] + 0,
        \   'type': l:match[2],
        \   'text': l:match[3],
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('sql', {
\   'name': 'pgsanity',
\   'executable': 'pgsanity',
\   'command': 'pgsanity',
\   'callback': 'ale_linters#sql#pgsanity#Handle',
\})

