set nocompatible
filetype off
syntax on
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'lervag/vimtex'
Plugin 'SirVer/ultisnips'
Plugin 'arcticicestudio/nord-vim'
Plugin 'preservim/nerdtree'
Plugin 'vim-airline/vim-airline'
call vundle#end()

"colorscheme gruvbox 
"set background=dark
colorscheme nord


" -----------------------------------------------------------------------------
"  Nord config
"  ----------------------------------------------------------------------------
let g:nord_bold_vertical_split_line = 1
" -----------------------------------------------------------------------------
"  Nord config 
"  ----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
"  VIMTEX config
"  ----------------------------------------------------------------------------
let g:tex_flavor = 'latex'
let g:vimtex_view_method = "skim"
"let g:vimtex_view_general_viewer
"          \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk = {
        \ 'aux_dir' : '',
        \ 'out_dir' : '',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
"set conceallevel=1
let g:tex_conceal='abdmg'
"let g:vimtex_quickfix_enabled = 0
" -----------------------------------------------------------------------------
"  VIMTEX config END
"  ----------------------------------------------------------------------------

filetype plugin indent on
set showmode
set showcmd
set matchpairs+=<:>
set nobackup
set noswapfile
set number
set ignorecase
set shiftwidth=3
set tabstop=2
set expandtab
set autoindent
set smartindent
set relativenumber
set ruler
imap jj <Esc>
imap jk <Esc>:w<Return>
map <F8> : !g++ % && ./a.out <CR>
set backspace=indent,eol,start
set spell
autocmd FileType make set noexpandtab
autocmd VimEnter * NERDTree
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}
highlight Visual term=reverse cterm=reverse guibg=Grey
set clipboard=unnamed

" -----------------------------------------------------------------------------
" UltiSnips config
" -----------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit = 'vertical'
" -----------------------------------------------------------------------------
" UltiSnips config
" -----------------------------------------------------------------------------
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
