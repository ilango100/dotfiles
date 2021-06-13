if exists('g:loaded_vim_clip')
    finish
endif
let g:loaded_vim_clip = 1

function! s:CopyToWLClipboard()
	if v:event["regname"] == ''
		call system("wl-copy -t text/plain", @")
	endif
endfunction

function! s:CopyToXClipboard()
	if v:event["regname"] == ''
		call system("xclip -selection clipboard", @")
	endif
endfunction

augroup clipboard
	au!
	if !empty($WAYLAND_DISPLAY)
		autocmd TextYankPost * call s:CopyToWLClipboard()
	elseif !empty($DISPLAY)
		autocmd TextYankPost * call s:CopyToXClipboard()
	endif
augroup END
