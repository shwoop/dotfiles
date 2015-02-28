set nocompatible                    " be improved
filetype off                        " no filetype detection

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" vim +PluginInstall +qall

Plugin 'gmarik/Vundle.vim'          " manage vundle
Plugin 'sjl/gundo.vim'              " visualize undo list
Plugin 'Valloric/YouCompleteMe'     " code completion
Plugin 'scrooloose/syntastic'       " syntax check
Plugin 'scrooloose/nerdtree'        " file explorer
Plugin 'Glench/Vim-Jinja2-Syntax'   " jinja2 template syntax highlights
Plugin 'altercation/vim-colors-solarized'   " solarized colourscheme

call vundle#end()                   " required

filetype plugin indent on           " filetype based indentation
syntax on                           " syntax
set background=dark                 " dark style fonts
set t_Co=256                        " fix terminal colours
let g:solarized_termcolors=16
colorscheme solarized

set hidden                          " quit with hidden buffers
set relativenumber                  " relative line numbers
set nu                              " classic line number follows cursor
set ts=4 sts=4 sw=4 expandtab       " spaces rather than tabs
set shiftround                      " indent by sw
set autoindent                      " auto indenting
set list  listchars=tab:▸\ ,eol:¬   " mark tabs and eol
set cc=80                           " highlight lines over 80 char
set tags=./tags;                    " ctags
set foldmethod=indent foldlevel=99  " Python compatible folding

let NERDTreeIgnore = ['\.pyc$']     " nerdtree ignore list
command NT NERDTree                 " remap NODETree to NT for lazE
