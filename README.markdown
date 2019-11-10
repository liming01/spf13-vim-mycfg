# My vim config #

Need to firstly install spf13[https://github.com/liming01/spf13-vim],
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
<leader>jw  : YcmCompleter GoTo<CR>
<leader>jww : YcmCompleter GoToImprecise<CR>
<leader>jd  : YcmCompleter GoToDefinition<CR>
<leader>jc  : YcmCompleter GoToReferences<CR>
<leader>js  : YcmCompleter GoToDeclaration<CR>
<leader>ji  : YcmCompleter GoToInclude<CR>
<leader>jt  : YcmCompleter GetType<CR>
<leader>jtt : YcmCompleter GetTypeImprecise<CR>
<leader>jh  : YcmCompleter GetParent<CR>

<leader>jr  : YcmCompleter RefactorRename<space>
<leader>j=  : YcmCompleter Format<CR>
<leader>jq  : YcmCompleter FixIt<CR>
```
- tag navigation:
```
g], <C-]>, <C-w>], <C-w>}, <leader>w], <leader>t]
```
- cscope navigation:
```
<leader>f (c|d|e|f|g|i|s|t)  # for cscope
<leader>h (c|d|e|f|g|i|s|t)  # for gnu global, gtags
```
- other plugins:
```
CtrlP                       : <leader>2f, <leader>bl, <D-r>, <leader>fu, <leader>fU
FZF							: <leader>2f, <leader>bf, <leader>hf, <leader>tf, <leader>mf,  <leader>ag,     # <object_type>f or F for <cword>
YankRing                    : <leader>yr
nerdcommenter               : <leader>c<space>, <leader>cc, <leader>cu
multiple-cursor             : <C-N>, <C-P>, <C-X>
nerdtree                    : <C-e>, <leader>e
tagbar                      : <leader>tt
vim-easymotion              : <leader><leader>w, <leader><leader>f, <leader><leader>e
incsearch-easymotion.vim    : z/, z?, zg/
tabular                     : <leader>a=
vim-expand-region           : +, -
vim-mark                    : <Leader>m,<Leader>n, <Leader>r, <Leader>*, <Leader># , <Leader>/, <Leader>?
vim-interestingwords        : <Leader>k (set interestingword),  <Leader>K (clear all),  n, N (search next/previous keymap)
mark                        : m<Space>  del all marks
TaskList.vim                : <leader>td
sessionman                  : <leader>sl, <leader>ss, <leader>sc
```
* others commands:
```
source/edit vimrc           : <leader>sv, <leader>ev
sudo write                  : :w!!
quite all buffers           : Q
re-search last search/ack   : <leader>q/, <leader>qa/
go file with line           : gF
go file in vertical split   : <leader>gf
visual block search/replace : *, #, <leader>vr
trim space                  : <leader>t<space>
copy file name              : <leader>cf, <leader>cr, <leader>cn
list keymap in sorted order : <leader>ml
Zoom current windows        : <leader>z
```
