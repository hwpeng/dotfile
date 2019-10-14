filetype plugin indent on
syntax on

set autoindent
set smartindent

set tabstop=4
set shiftwidth=4

set showmatch
set ruler
set incsearch
set smartcase

set nu rnu

let g:go_version_warning = 0

colo focuspoint

" Highlight current line
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" Create teh `tags` file
command! MakeTages !ctags -R .

" English check
" set spell spelllang=en_us

set linebreak

set showcmd

" Set leader key to space
let mapleader=" "
let maplocalleader=" "

set timeoutlen=200

set splitbelow splitright

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug in management
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'nachumk/systemverilog.vim'
Plug 'tpope/vim-fugitive'
Plug 'lervag/vimtex'
Plug 'vimwiki/vimwiki'
Plug 'scrooloose/nerdcommenter'

call plug#end()

" vimtex settings
let g:vimtex_compiler_latexmk = {
	\ 'callback' : 0,
	\ 'build_dir': 'build',
	\}
let g:tex_flavor = 'latex'

" nerdtree settings
nnoremap <leader>n :NERDTree<CR>

" nerdcommenter settings
let g:NERDSpaceDelims = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" Disable arrow keys 
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Close file easily
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>1q :q!<CR>

" Tag browsing
nnoremap <leader>g :vsp <CR>:exec("tag ".expand("<cword>"))<CR> 

" Google selected text
function! GoogleSearch()
	let searchterm = getreg("g")
	silent! exec "silent! !google-chrome \"http://google.com/search?q=" . searchterm . "\" &"
endfunction
vnoremap <leader>? "gy<Esc>:call GoogleSearch()<CR><c-L>

" Navigating with guides
inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
map <leader><leader> <Esc>/<++><Enter>"_c4l

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Verilog 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Read an empty verilog module template and move cursor to name
nnoremap <leader>v :read $HOME/.vim/snippet/.module.v<CR>$i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Latex 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Word count
autocmd FileType tex map <leader>wc :w !detex \| wc -w<CR>
" Snippet
autocmd FileType tex inoremap <leader>fr \begin{frame}{}<Enter><++><Enter>\end{frame}<Enter><Enter><++><Esc>4k11li
autocmd FileType tex inoremap <leader>em \emph{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>bf \textbf{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>in \input{}<Enter><Enter><++><Esc>2kT{i
autocmd FileType tex inoremap <leader>res \resizebox{}{<++>}{<Enter>\centering<Enter><++><Enter>}<Esc>3kf}i
autocmd FileType tex vnoremap <leader> <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
autocmd FileType tex inoremap <leader>it \textit{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>ct \textcite{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap <leader>li <Enter>\item<Space>
autocmd FileType tex inoremap <leader>re \ref{}<Space><++><Esc>T{i
autocmd FileType tex inoremap <leader>ta \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
autocmd FileType tex inoremap <leader>fi \begin{figure}<Enter>\includegraphics[width=0.5\textwidth]{}<Enter>\end{figure}<Enter><++><Esc>2kf{a
autocmd FileType tex inoremap <leader>se \section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap <leader>seb \section[]{<++>}<Enter><Enter><++><Esc>2kf]i
autocmd FileType tex inoremap <leader>sse \subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap <leader>ssse \subsubsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap <leader>up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
autocmd FileType tex nnoremap <leader>up /usepackage<Enter>o\usepackage{}<Esc>i
autocmd FileType tex inoremap <leader>co \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
autocmd FileType tex inoremap <leader>no \node[] (<++>) {<++>};<Enter><++><Esc>kf]i
autocmd FileType tex inoremap <leader>ar \draw[-latex] () -- (<++>);<Enter><++><Esc>kf)i

	
" Local vim configure file
try
	source ~/.vimrc_local
catch
	" No such file? Just ignore it.
endtry
