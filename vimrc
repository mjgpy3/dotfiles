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

function! CommitFromGitDirectory()
  let l:base_path = '.'
  let l:pwd=fnamemodify('.', ':p')
  while empty(globpath(l:base_path, '.git'))
    let l:base_path = l:base_path . '/..'
    if simplify(fnamemodify('.', ':p') . l:base_path) == '/'
      echo ".git not found in ancestor directories!"
      return
    endif
  endwhile
  echo "Found . git at " . l:base_path
  let l:cmd = "!git add --all " . l:base_path . " && git commit -v"
  execute l:cmd
endfunction

let maplocalleader=","
let mapleader="\\"

function! MjgJsTestEntity(type, has_block)
  let l:fn_call = "normal! oTHINGfunction () {\<CR>});"
  let l:fn_call = substitute(l:fn_call, "THING", a:type, "")
  execute l:fn_call
  if a:has_block
    execute "normal! ?''\<CR>"
  endif
endfunction

function! MapMjgJsTest()
  nnoremap <buffer> <localleader>d :call MjgJsTestEntity("describe('', ", 1)<ENTER>
  nnoremap <buffer> <localleader>i :call MjgJsTestEntity("it('', ", 1)<ENTER>
  nnoremap <buffer> <localleader>b :call MjgJsTestEntity("beforeEach(", 0)<ENTER>
endfunction

function! MjgJsFunction()
  execute "normal! $i function () {\<CR>}"
  execute "normal! ?()\<CR>"
endfunction

function! MjgJsSemicolon()
  execute "normal! $%a;"
endfunction

function! MapMjgJs()
  nnoremap <buffer> <localleader>f :call MjgJsFunction()<ENTER>
  nnoremap <buffer> <localleader>s :call MjgJsSemicolon()<ENTER>
  nnoremap <buffer> <localleader>c I// <esc>
endfunction

function! MjgMarkdownCode()
  execute "normal! o\`\`\`\<CR>\`\`\`\<esc>O"
endfunction

function! MjgMarkdownBullet()
  let l:line = getline('.')
  if l:line =~ '\s*-'
    execute "normal! yyp0f-lDa "
  else
    execute "normal! o  - "
  endif
endfunction

function! MapMjgMarkdown()
 set spell
 nnoremap <buffer> <localleader>c :call MjgMarkdownCode()<ENTER>
 nnoremap <buffer> <localleader>b :call MjgMarkdownBullet()<ENTER>
endfunction

au FileType markdown call MapMjgMarkdown()
au FileType javascript call MapMjgJs()
au User MapMjgJsTestEvent call MapMjgJsTest()

" Detect JS Test files
au BufNewFile,BufRead *test.js,test*.js,*Test.js,*Spec.js,*spec.js doautocmd User MapMjgJsTestEvent

nnoremap <buffer> <leader>a :call CommitFromGitDirectory()<ENTER>
