# My vim config #

Need to firstly install spf13[https://github.com/spf13/spf13-vim],
after that git clone this repo, and run shell install.cmd on Windows
or install.sh on Mac/Linux.

This vimrc config include 2 types: simple and complex configs.
The default is simple config, only some keymap without any plugin;
while the complex config use a lot of plugins includes spf13.

Please use command 'vim -u ~/.vimrc.complex' to run vim with the complex config.

Tag Navigation
-------------
- YouCompleteMe:
```
<leader>jw :YcmCompleter GoTo
<leader>jd :YcmCompleter GoToDefinition
<leader>js :YcmCompleter GoToDeclaration
<leader>jt :YcmCompleter GetType<CR>
<leader>jh :YcmCompleter GetParent<CR>
```
- tag navigation:
```
g], <C-]>, <C-w>], <leader>w], <leader>t]
```
- cscope navigation:
```
<leader>f (c|d|e|f|g|i|s|t)
```
- other plugins:
```
CtrlP                       : <leader>cp, <leader>bl, <D-r>, <leader>fu, <leader>fU
YankRing                    : <leader>yr
nerdcommenter               : <leader>c<space>, <leader>cc, <leader>cu
multiple-cursor             : <C-N>, <C-P>, <C-X>
nerdtree                    : <C-e>, <leader>e
tagbar                      : <leader>tt
vim-easymotion              : <leader><leader>w, <leader><leader>fe
tabular                     : <leader>a=
vim-expand-region           : +, -
vim-mark                    : <Leader>m,<Leader>n, <Leader>r, <Leader>*, <Leader># , <Leader>/, <Leader>?
mark                        : m<Space>  del all marks
TaskList.vim                : <leader>td
```
* others commands:
```
source/edit vimrc           : <leader>sv, <leader>ev
sudo write                  : : w!!
quite all buffers           : Q
re-search last search/ack   : <leader>q/, <leader>qa/
go file with line           : gF
go file in vertical split   : <leader>gf
visual block search/replace : *, #, <leader>vr
trim space                  : <leader>t<space>
copy file name              : <leader>cf, <leader>cr, <leader>cn
list keymap in sorted order : <leader>lm
Zoom current windows        : <leader>z
```
