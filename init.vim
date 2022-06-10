" default conf
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" for go
autocmd Filetype go setlocal tabstop=4 shiftwidth=4 noexpandtab

set smartindent
set relativenumber
set nu
set hidden
set nohlsearch
set noerrorbells
set nowrap
set incsearch
set ignorecase
set scrolloff=8
set signcolumn=yes
set colorcolumn=80
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set termguicolors
set clipboard=unnamed
set updatetime=100

call plug#begin(stdpath('data') . '/plugged')
  Plug 'gruvbox-community/gruvbox'

  Plug 'neovim/nvim-lspconfig'

  Plug 'preservim/nerdtree'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'vim-airline/vim-airline'
  Plug 'tpope/vim-fugitive'

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'numToStr/Comment.nvim'

  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/echodoc'
  " Plug 'hrsh7th/nvim-cmp'

  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  
call plug#end()

" vim-go conf ----------------------------------
let g:go_doc_popup_window = 1
" let g:go_auto_type_info = 1
" let g:go_auto_sameids = 1
" let g:go_def_mapping_enabled=0
" Or, you could use neovim's floating text feature.
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
let g:deoplete#enable_at_startup = 1


let g:gruvbox_contrast_dark = 'dark'
colorscheme gruvbox

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-a> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-P> :Files<CR>

let NERDTreeMapOpenVSplit='v'
let NERDTreeMapOpenSplit='s'
let NERDTreeShowHidden=1

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "javascript", "css", "tsx", "typescript" },

  highlight = {
    enable = true,              
  },
}

require('Comment').setup()
EOF

" LSP CONFIG ----------------------------------
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'tsserver', 'cssls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
    capabilities = capabilities
  }
end
EOF

" FZF Config -----------------
" " This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }


" let $FZF_DEFAULT_OPTS="--ansi"

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


