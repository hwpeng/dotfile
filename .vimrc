syntax on
filetype plugin indent on

set autoindent
set smartindent

set tabstop=4
set shiftwidth=4

set showmatch
set ruler
set incsearch

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plug in management
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'nachumk/systemverilog.vim'

call plug#end()

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

" Snippets
" Read an empty verilog module template and move cursor to name
nnoremap ,v :read $HOME/.vim/snippet/.module.v<CR>$i

" Disable arrow keys 
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
