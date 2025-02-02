function! s:inCodeFence()
    " Search backwards for the opening of the code fence.
	call search("^```.*$", "bcW")
    " Move one line down
	normal! j
    " Move to the begining of the line at start selecting
	normal! 0V
    " Search forward for the closing of the code fence.
	call search("```", "cW")
	" Move to a line above to avoid selecting the ending block
	normal! k
endfunction

function! s:aroundCodeFence()
    " Search backwards for the opening of the code fence.
	call search("^```.*$", "bcW")
	normal! 0V
    " Search forward for the closing of the code fence.
	call search("```", "eW")
endfunction

xnoremap <buffer> <silent> if :call <sid>inCodeFence()<cr>
onoremap <buffer> <silent> if :call <sid>inCodeFence()<cr>
xnoremap <buffer> <silent> af :call <sid>aroundCodeFence()<cr>
onoremap <buffer> <silent> af :call <sid>aroundCodeFence()<cr>
