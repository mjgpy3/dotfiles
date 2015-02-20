if !empty($MY_RUBY_HOME)
   let g:ruby_path = join(split(glob($MY_RUBY_HOME.'/lib/ruby/*.*')."\n".glob($MY_RUBY_HOME.'/lib/rubysite_ruby/*'),"\n"),',')
endif

filetype plugin indent on
syntax on

augroup myfiletypes
  autocmd!
  autocmd FileType ruby,html,haskell,puppet setlocal ai sw=2 sts=2 et
  autocmd Filetype javascript,coffee,python setlocal ai sw=4 sts=4 et
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

" Exit insert mode, write with 'jk'
inoremap jk <Esc>:w<cr>

" Documentation off of a def signiture
:ca rd call DefDoc()
:ca rs call BuildSpecTest()

let mapleader=","

" I put this where I don't want to leave technical debt...
let @g='O# Gilli did ths!€kb€kbis!!!'

" Kill pesky arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

function DefDoc()
	let line=getline('.')
	let comment_lines=["# Xx", "#"]
	let indents=GetIndent()
	let params=MyStrip(split(line, '(')[-1])[:-2]
	for param in split(params, ',')
		let clean_param = MyStrip(param)
		let param_name = matchstr(clean_param, '^\w*')
		call add(comment_lines, '# @param [Xx] ' . param_name . ' Xx') 
	endfor
	call add(comment_lines, '# @return [Xx] Xx')
	let comment_lines=reverse(comment_lines)
	for line in comment_lines
		let indented_line=indents . line
		-1put =indented_line
	endfor
endfunction

function BuildSpecTest()
	let indents=GetIndent()
	let indentedtest="\n" . indents . "it 'Xx' do\n" . indents . "end\n"
	put =indentedtest
	call search('Xx', 'b')
	normal cw
endfunction

function MyStrip(str)
	return substitute(a:str, '^\s\+\|\s\+$', '', 'g')
endfunction

function GetIndent()
	let line=getline('.')
	return matchstr(line, '^\s*')
endfunction
