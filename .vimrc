"""""""""""""""""""""""""""""""""""""""""""
"  Vim (MacVim) configuration file
"""""""""""""""""""""""""""""""""""""""""""
"  By Murat Taşdemir 2014 on MacBook Air 
"""""""""""""""""""""""""""""""""""""""""""
set langmenu=en_US.UTF-8    " sets the language of the menu (gvim)
" ----------------------------------------------------------
" Vundle Config 
" ----------------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
" MY PLUGINS
Plugin 'nelstrom/vim-markdown-folding'
" Below are different markdown syntax highlighting plugins
" Plugin 'tpope/vim-markdown'
"Plugin 'gabrielelana/vim-markdown'
" Plugin 'plasticboy/vim-markdown'
"Plugin 'hallison/vim-markdown'
Plugin 'sheerun/vim-polyglot'   " Syntax highlighting
Plugin 'vim-pandoc/vim-pandoc'   " pandoc integration of vim
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'yegappan/mru'    " Recently used files
Plugin 'scrooloose/nerdtree'	" File explorer fir vim
Plugin 'vimwiki/vimwiki'
Plugin 'michal-h21/vim-zettel'	"Zettelkasten for vim (my own forked and modified version)
Plugin 'mileszs/ack.vim'
Plugin 'godlygeek/tabular'      "Tabularize plugin
Plugin 'vim-pandoc/vim-pandoc-syntax'  " Syntax highlighting for pandoc markdown (requires 'vim-pandoc' plugin)
Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/goyo.vim'	" Distraction free writing
Plugin 'xolox/vim-misc'         " Required for 'vim-session' plugin below
Plugin 'xolox/vim-session'	" Better session management
Plugin 'xolox/vim-colorscheme-switcher'

" Colorschemes (many of them are installed manually)
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'cocopon/iceberg.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" ------------------------------------------------------------
" ------------------------------------------------------------
" Colorschemes -----------------------------------------------
" NOTE:  since there is also a '.gvimrc' file, 
" these settings will only affect terminal vim.  
if has('gui_running')
    let g:solarized_contrast = 'high'
    set guifont=Iosevka:h18
    set antialias
    set background=dark
    colorscheme gruvbox
else
    set background=dark
    colorscheme zenburn
"    colorscheme frood
endif

" colorscheme blue
" colorscheme desert256
" colorscheme zellner
" colorscheme kalisi
" colorscheme solarized
" colorscheme moria
" set background=light
" colorscheme leya (önceki)
" colorscheme clarity "önceki
" colorscheme editplus
" colorscheme zellner
" colorscheme sublimemonokai

"""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set number                  " Show line numbers at startup
set hidden                  " Don't prompt to save hidden windows until exit
set history=200             " How many lines of history to save
set nohlsearch              " No Hilight searching
set ignorecase              " Case insensitive
set incsearch               " Search as you type
set infercase               " Completion recognizes capitalization
set laststatus=2            " Always show the status bar
set nobackup                " No backups left after done editing
set nowb
set noswapfile
set encoding=utf8           " UTF-8 by default
set smartcase               " Lets you search for ALL CAPS
set ai                      " Auto indent
set si                      " Smart indent
set wrap                    " Wrap lines
set linebreak               " do not split words at the end of lines
set nolist                  " required for the previous option to work properly
set showbreak=              " Show for lines that have been wrapped, like Emacs
set softtabstop=4 shiftwidth=4 expandtab
set spl=tr nospell
set guioptions-=r           " Remove scrollbar in fullview
set clipboard+=unnamed  " use the clipboards of vim and win
set paste               " Paste from a windows or from vim
"set go+=a               " Visual selection automatically copied to the clipboard
set statusline+=%F          " Show full path in status bar

set wildmode=list:longest,full " List all options and complete
" set wildignore=*.nav,*.snm,*.synctex.gz,*.o,*~,.git,node_modules  " Ignore certain files in tab-completion
syntax enable
" ----------------------------------------------------------------------------
" My commands and mappings
" ----------------------------------------------------------------------------
" Make their keymappings use comma
let mapleader = ","
let maplocalleader = ","

" CDC = Change to Directory of Current file
command! CDC cd %:p:h
" Do the same thing with mapping
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

nnoremap <leader>rm :call delete(expand('%')) \| bdelete!<CR>
" ----------------------------------------------------------------------------
" Fix improper highligting of underscores in latex equations
" ----------------------------------------------------------------------------
 function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown,*.txt,*.note call MathAndLiquid()
" ----------------------------------------------------------------------------
" PLUGIN SETTINGS
" ----------------------------------------------------------------------------
" --------------------------------------------
" Below is for session management (vim-sessions plugin)
:let g:session_autoload = 'no'
:let g:session_autosave = 'no'
" Don't save hidden and unloaded buffers in sessions.
set sessionoptions-=buffers

" --------------------------------------------
" Add .note extension to vim-pandoc plugin
let g:pandoc_extensions_table = {
            \'extra': ['text', 'txt'],
            \'html': ['html', 'htm'],
            \'json' : ['json'],
            \'latex': ['latex', 'tex', 'ltx'],
            \'markdown' : ['markdown', 'mkd', 'md'],
            \'pandoc': ['pandoc', 'pdk', 'pd', 'pdc'],
            \'native' : ['hs'],
            \'rst' : ['rst'],
            \'textile': ['textile'] }
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]

" ----------------------------------------------------
" --- vim-zettel settings ----------------------------
" The vim-zette settings below from 
"    [this reddit](https://www.reddit.com/r/Zettelkasten/comments/fidaum/vimzettel_an_addon_for_the_vimwiki_addon_for_vim/?utm_source=share&utm_medium=web2x)
let g:vimwiki_ext2syntax = {'.md': 'markdown'}
let g:vimwiki_list = [{"path":"~/Google Drive/zettel-notes/", 'ext': '.md', 'syntax': 'markdown', 'auto_tags': 1, 'auto_toc': 1}]
let g:vimwiki_use_mouse = 1
let g:vimwiki_folding = 'expr'
let g:vimwiki_auto_chdir = 1


" Treat as wiki files only in vimwiki directory 
let g:vimwiki_global_ext = 0


" Format for new files
let g:zettel_format = "%Y%m%d%H%M-%title"
" Template for new files
let g:zettel_options = [{"front_matter" : { "csl": "'/references/apa-tr.csl'", "bibliography": "'/references/zettel.bib'", "tags" : "" }, "template" :  "~/.vim/templates/zettel.tpl"}]
"let g:zettel_options = [{"template" :  "~/.vim/templates/zettel.tpl"}]

" Create a new note with the selected text as the note title by typing z.
" xnoremap z :call zettel#vimwiki#zettel_new_selected()<CR>
xmap z <Plug>ZettelNewSelectedMap
" Create new note by typing <leader>zn
nnoremap <leader>zn :ZettelNew<cr><cr>:4d<cr>:w<cr>ggA
" Turn a file name under the cursor in your note into a link to the file with gZ.
nmap gZ <Plug>ZettelReplaceFileWithLink
" <leader>vt starts a tag search letting you open files with matching tags.
nnoremap <leader>vt :VimwikiSearchTags<space>
" <leader>vs does the same thing but with a full text search.
nnoremap <leader>vs :VimwikiSearch<space>
" This mapping runs two Vimwiki functions that keep the Vimwiki 
"    tags file up-to-date and generates an index by tag of file links 
"    in the index.wiki file.
nnoremap <leader>gt :VimwikiRebuildTags!<cr>:VimwikiGenerateTagLinks<cr><c-l>
" In insert mode [[ let you search for existing notes to insert as a link to the current file.
nnoremap <leader>zl :ZettelSearch<cr>
" In insert mode when you type [[ the ZettelSearch function is triggered. 
"    This runs the silver searcher in a new window split and dynamically
"    shows search results as you type. Hitting enter on one of its search 
"    result lines inserts a link to that file in your note.
" inoremap [[ [[<esc>:ZettelSearch<CR>
imap <silent> [[ [[<esc><Plug>ZettelSearchMap
" This one is useful when you want to know what zettels link to the current one. 
"    It opens a window split with a list of those files.
nnoremap <leader>bl :VimwikiBacklinks<cr>

" -----------------------------------------------------------------------

" NERDTree
nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <Leader>v :NERDTreeFind<CR>
" Tell ack.vim to use ag (the Silver Searcher) instead
 let g:ackprg = 'ag --vimgrep'


" Highlight YAML frontmatter in Markdown files
let g:vim_markdown_frontmatter = 1

" Lightline plugin settings
" To replace fullpath with only filename use 'filename'
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [['mode', 'paste'], ['absolutepath', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_ok', 'linter_errors','fileencoding', 'filetype']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ }
function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction
function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction
function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

" Update and show lightline but only if it's visible (e.g., not in Goyo)
autocmd User ALELint call s:MaybeUpdateLightline()
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

" Markdown highlighting stuff
highlight link markdownH1 PreProc
highlight link markdownH2 PreProc
highlight link markdownLink Character
highlight link markdownBold String
highlight link markdownItalic Statement
highlight link markdownCode Delimiter
highlight link markdownCodeBlock Delimiter
highlight link markdownListMarker Todo

" Goyo setup for distraction free writing
let g:goyo_width = 104      " Increase width (default 80 characters)
" Start Goyo ":Goyo" and to leave Goyo mode ":Goyo!"
"
" The following is for templates
augroup templates
  au!
" read in templates files for new files
  autocmd BufNewFile *.* silent! execute '0r ~/.vim/templates/skeleton.'.expand("<afile>:e")
augroup END


