" Vim plugin to send selection to terminal of choice
" Author:	Ilango Rajagopal <ilangokul@gmail.com>
" License:	This file is placed in public domain

if exists('s:sendTermBuf')
"	finish
endif
let  s:sendTermBuf = "notset"

if !exists('g:langTerms')
	let g:langTerms = {'python': 'python'}
endif

function SendToTerm() range

	" (Re)Start a terminal if not found
	if len(term_list()) == 0
		if has_key(g:langTerms, &ft)
			let s:sendTermBuf = term_start(g:langTerms[&ft], {"term_finish": "close" } )
		else
			let s:sendTermBuf = term_start($SHELL, {"term_finish": "close"})
		endif
		wincmd p
		echo "New Term started"
	end

	" Find which terminal to use
	if s:sendTermBuf =~ 'notset' || !bufexists(s:sendTermBuf)
		let terms = term_list()
		if len(terms) > 1
			" TODO: Ask for choice
			let s:sendTermBuf = terms[0]
		else
			let s:sendTermBuf = terms[0]
		endif
	endif

	" Send to term, finally
	let i = a:firstline
	let buf = ""
	while i <= a:lastline
		let line = getline(i)."\n"

		" Skip if line is empty
		if len(trim(line)) == 0
			let i += 1
			continue
		end
		let buf .= line
		let i += 1
	endwhile
	call term_sendkeys(s:sendTermBuf, buf)
	call setpos('.', [0, a:lastline, 0, 0])
endfunction

map <unique> <Plug>SendToTerm :call SendToTerm()<CR>
map <unique> <Leader>t  <Plug>SendToTerm

