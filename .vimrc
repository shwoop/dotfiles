set nocompatible                    " be improved
filetype off                        " no filetype detection

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" PLUGIN DEPLOYMENT COMMANDS

" Install Vundle
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

" Have Vundle install the below plugins
" vim +PluginInstall +qall

" YouCompleteMe needs to be built and depends cmake
" apt-get install cmake
" cd ~/.vim/bundle/YouCompleteMe
" ./install.py --clang-completer --go-completer --racer-completer

" Don't forget Ctags
" apt-get install ctags
" cd <repo>/ && ctags -R .

Plugin 'gmarik/Vundle.vim'          " manage vundle
" lugin 'sjl/gundo.vim'              " visualize undo list
Plugin 'Valloric/YouCompleteMe'     " code completion
Plugin 'scrooloose/syntastic'       " syntax check
Plugin 'scrooloose/nerdtree'        " file explorer
" Plugin 'Glench/Vim-Jinja2-Syntax'   " jinja2 template syntax highlights
Plugin 'altercation/vim-colors-solarized'   " solarized colourscheme
Plugin 'kien/rainbow_parentheses.vim'
" Plugin 'davidhalter/jedi-vim'
" Plugin 'ervandew/supertab'
" Plugin 'rking/ag.vim'               " silver searcher plugin
" Plugin 'nvie/vim-flake8'            " flake8 plugin (f7)
" Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'

call vundle#end()                   " required

filetype plugin indent on           " filetype based indentation
syntax enable                          " syntax
set background=dark                 " dark style fonts
" set t_Co=256                        " fix terminal colours
set t_Co=16                         " fix terminal colours
" let g:solarized_termcolors=16
let g:solarized_termcolors=256
colorscheme solarized

" jshint lint for js files
let g:syntastic_javascript_checkers = ['jshint']

" let g:syntastic_python_checkers = ["flake8", "mypy"]

set hidden                          " quit with hidden buffers
set relativenumber                  " relative line numbers
set nu                              " classic line number follows cursor
" set ts=2 sts=2 sw=2 expandtab       " spaces rather than tabs
set shiftround                      " indent by sw
set autoindent                      " auto indenting
" set list  listchars=tab:▸\ ,eol:¬   " mark tabs and eol
set cc=80                           " highlight lines over 80 char
highlight ColorColumn ctermbg=10    " green column at 80
set tags=./tags;                    " ctags
set foldmethod=indent foldlevel=99  " Python compatible folding

let NERDTreeIgnore = ['\.pyc$']     " nerdtree ignore list
command NT NERDTree                 " remap NODETree to NT for lazE
command Nt NERDTree

" easier moving in windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h

" better rainbow parenthesis
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" supertab config
" let g:SuperTabDefaultCompletionType = "context"

" jedi config
" let g:jedi#popup_on_dot = 0

" let g:ag_working_path_mode="r"     " search from root of project

autocmd BufEnter * :syntax sync fromstart

set guifont=Monospace\ 12
" imap ii <Esc>
let g:deoplete#enable_at_startup = 1

let g:ycm_auto_trigger = 1

set rtp+=~/.vim/bundle/YouCompleteMe
