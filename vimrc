filetype plugin indent on
syntax on

augroup myfiletypes
  autocmd!
  autocmd FileType python,javascript,ruby,html,haskell,puppet setlocal ai sw=2 sts=2 et
augroup END

" Set toggle spelling key
map <F6> :setlocal spell! spelllang=en_us<CR>

" Set toggle line number key
map <F7> :setlocal number!<CR>

" Keep backup and temp files in one place
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

" Automatically change directory to current file
set autochdir

" Make vim brighten up text for a dark background
set background=dark

" Unix file format
set fileformats=unix

" Stop those error bells!
set noerrorbells
set visualbell
set t_vb=

" Search highlighting
set hlsearch

" Show trailing whitespace
highlight ExtraWhitespace ctermbg=white guibg=darkgreen
match ExtraWhitespace /\s\+$/

" Ctrl+s to save
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a
:imap <c-s> <Esc><c-s>

" Kill pesky arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

function MyStrip(str)
	return substitute(a:str, '^\s\+\|\s\+$', '', 'g')
endfunction

function GetIndent()
	let line=getline('.')
	return matchstr(line, '^\s*')
endfunction

let maplocalleader=","
let mapleader=","

function! MjgJsTestDesc(type)
  let l:fn_call = "normal! oTHING('', function () {\<CR>});"
  let l:fn_call = substitute(l:fn_call, "THING", a:type, "")
  execute l:fn_call
  execute "normal! /''\<CR>"
endfunction

function! MapMjgJsTest()
  nnoremap <buffer> <localleader>d :call MjgJsTestDesc('describe')<ENTER>
  nnoremap <buffer> <localleader>i :call MjgJsTestDesc('it')<ENTER>
endfunction

au User MapMjgJsTestEvent call MapMjgJsTest()

" Detect JS Test files
au BufNewFile,BufRead *test.js doautocmd User MapMjgJsTestEvent
au BufNewFile,BufRead test*.js doautocmd User MapMjgJsTestEvent
au BufNewFile,BufRead *Test.js doautocmd User MapMjgJsTestEvent
au BufNewFile,BufRead *Spec.js doautocmd User MapMjgJsTestEvent
au BufNewFile,BufRead *spec.js doautocmd User MapMjgJsTestEvent
