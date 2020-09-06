" WELCOME TO VIMRC
" 
" KEEP 10 EMPTY LINES BETWEEN SECTIONS
" KEEP A SECTION COMMENT FOR EACH SECTION
" 
" HOW TO USE:
" 1. INSTALL VIM (A VERSION THAT SUPPORTS PYTHON)
" 2. INSTALL VIM-PLUG (see https://github.com/junegunn/vim-plug)
" 3. INSTALL PLUGINS THROUGH VIM-PLUG (same link as above)
" 4. LOOK THROUGH THIS FILE AND EACH PLUGIN REPO PAGE TO UNDERSTAND USE CASES (repos are listed after "Plug" and are on GitHub)










" GENERAL SECTION

" so that we can click and scroll as expected
set mouse=a

" set leader key to comma
let mapleader = ","
let maplocalleader = "."

" set number of visual spaces per tab character
set tabstop=4
set shiftwidth=4

" use spaces for tabs (OFF)
"
" set softtabstop=4
" set expandtab

" show relative line number
set number
set relativenumber
highlight LineNr ctermfg=black

" highlight current line
set cursorline

" visual autocomplete for command menu
set wildmenu

" load filetype specific indent files
filetype indent on

" allow easy split creation
nnoremap <leader>d : sp<CR>
nnoremap <leader>r : vsp<CR>

" allow easy split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-w> :q<CR>

" easily open location list for errors
nnoremap <C-D> :CocDiagnostics<CR>

" have backspace work normally in insert mode
set backspace=indent,eol,start

" redraw only when we need to (not in the middle of macros)
set lazyredraw

" highlight matching [{()}]
set showmatch

" we don't want autocomplete preview in scratch window
set completeopt-=preview

" allow easy pasting of yanked, not cut, text
map <leader>p "0p

" don't wait for special characters after escape key
set ttimeoutlen=0

" copy
map <leader>y "+y

" allow 100 tabs rather than just 10
set tabpagemax=100

" easy command mode
nnoremap ; :

" repeat f or t
nnoremap ' ;











" OCAML SECTION

set rtp^="/Users/sahil/.opam/4.09.0/share/ocp-indent/vim"
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" for completions
inoremap <C-n> <C-x><C-o>
inoremap <C-@> <C-n>

" for jump to definition in merlin
nnoremap <localleader>d :MerlinLocate<CR>










" VIM-PLUG SECTION
" see https://github.com/junegunn/vim-plug for use
call plug#begin()

" LIST PLUGINS HERE
Plug 'mattn/emmet-vim'
Plug 'lervag/vimtex'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
Plug 'APZelos/blamer.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'yggdroot/indentline'
Plug 'AndrewRadev/tagalong.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
" Note: this requires additional Font installation, see
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdcommenter'
Plug 'godlygeek/tabular'
Plug 'pangloss/vim-javascript'
Plug 'wakatime/vim-wakatime'
Plug 'mitermayer/vim-prettier'
Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'takac/vim-hardtime'

call plug#end()










" LIMELIGHT/GOYO CONFIG

" easy enable/disable
nnoremap <leader>gy :call GoyoToggle()<cr>

function! GoyoToggle()
    if exists('#goyo')
     	Goyo!
    else
		Goyo
    endif
endfunction

" set dimmed color for limelight
let g:limelight_conceal_ctermfg = 'gray'

" enable Limelight on entering Goyo,
" get rid of weird carrot line at bottom
" get rid of cursorline in Goyo
" quit Goyo and vim together
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  hi StatusLineNC ctermfg=white
  Limelight
  set nocursorline
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
  Limelight!
  set cursorline
  AirlineToggle
  AirlineToggle
  AirlineRefresh
  highlight LineNr ctermfg=black
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()









" VIM FUGITIVE CONFIG

" Easy status
nmap <leader>gs :G<CR>

" better diff management (useful when managing merges with vim-fugitive)
nmap d2 :diffget //2<Cr>
nmap d3 :diffget //3<Cr>










" VIM PRETTIER CONFIG

" run prettier on ctrl-y
map <C-y> :Prettier<CR>









" BLAMER.NVIM CONFIG

" make blamer faster and grey colored
highlight Blamer guifg=lightgrey
let g:blamer_delay = 150










" NERDCOMMENTER CONFIG

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Remove 'Press ? for help'
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1










" FZF CONFIG

" Floating window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.4 } }

" Search files with Ctrl-p
map <C-p> :GFiles<CR>

" Search files with Ctrl-o
map <C-o> :Files<CR>

" Search buffers with Ctrl-i
map <C-i> :Buffers<CR>

" Search directory of current file with Ctrl-u
map <C-u> :FZF %:p:h<CR>

" Search commands with Ctrl-i
map <C-t> :Commands<CR>

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1










" EMMET CONFIG

" How to use: https://docs.emmet.io/abbreviations/syntax/
" install only for HTML/CSS iles
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" set lead key to ',' (so we can use ',,' to trigger emmet)
let g:user_emmet_leader_key = ','










" TAGALONG CONFIG

" We want tagalong to notify us when it changes a tag
let g:tagalong_verbose = 1










" NERDTREE CONFIG

" We want to open NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" Close vim if the only window left open is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif










" AIRLINE CONFIG

" Tell airline we installed a patched font so it displays correctly
let g:airline_powerline_fonts = 1

" Setup theme
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

" use airline's tabline too
let g:airline#extensions#tabline#enabled = 1










" CoC CONFIG (copied from repo "neoclide/coc.nvim")

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
