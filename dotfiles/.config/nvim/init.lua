local g   = vim.g
local o   = vim.o
local opt = vim.opt
local A   = vim.api

-- cmd('syntax on')
-- vim.api.nvim_command('filetype plugin indent on')

o.termguicolors = true
-- o.background = 'dark'

-- Do not save when switching buffers
-- o.hidden = true

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Better editor UI
o.number = true
o.numberwidth = 2
o.relativenumber = true
o.signcolumn = 'yes'
o.cursorline = true

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.cindent = true
o.autoindent = true
o.wrap = true
o.textwidth = 300
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = true
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
-- BUG This option causes an error!
-- o.jumpoptions = 'view'

-- BUG: this won't update the search count after pressing `n` or `N`
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- o.lazyredraw = true

-- Better folds (don't fold by default)
-- o.foldmethod = 'indent'
-- o.foldlevelstart = 99
-- o.foldnestmax = 3
-- o.foldminlines = 1
--
opt.mouse = "a"

-- Map <leader> to space
g.mapleader = ' '
g.maplocalleader = ' '


-------------------------------------------------
-- COLORSCHEMES
-------------------------------------------------

-- Uncomment just ONE of the following colorschemes!
local ok, _ = pcall(vim.cmd, 'colorscheme PaperColor')

-- Highlight the region on yank
A.nvim_create_autocmd('TextYankPost', {
    group = num_au,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 120 })
    end,
})

-------------------------------------------------
-- KEYBINDINGS
-------------------------------------------------

local function map(m, k, v)
   vim.keymap.set(m, k, v, { silent = true })
end

-- Switch to last Buffer 
map('n', '<leader><tab>', '<C-^><CR>')

-- Quickfix shortcuts
map('n', '<A-j>', ':cnext<CR>')
map('n', '<A-k>', ':cprev<CR>')
map('n', '<A-o>', ':copen<CR>')
map('n', '<A-c>', ':cclose<CR>')

-- Mimic shell movements
map('i', '<C-E>', '<ESC>A')
map('i', '<C-A>', '<ESC>I')

-- Load recent sessions
map('n', '<leader>sl', '<CMD>SessionLoad<CR>')

-- Keybindings for telescope
map('n', '<leader>fr', '<CMD>Telescope oldfiles<CR>')
map('n', '<leader>ff', '<CMD>Telescope find_files<CR>')
map('n', '<leader>fb', '<CMD>Telescope file_browser hidden=true grouped=true hijack_netrw=true<CR>')
map('n', '<leader>fw', '<CMD>Telescope live_grep<CR>')

-- Keybindings for fugitive
map('n', '<leader>gl', ':G difftool<CR>')
map('n', '<leader>gd', ':Gdiffsplit<CR>')

-------------------------------------------------
-- DASHBOARD
-------------------------------------------------

local db = require('dashboard')
local home = os.getenv('HOME')

db.custom_header = {
    '',
    '                                             oo',
    '                                            o"  $',
    '                                          " o   $',
    '                                         "      $',
    '                                        $      $$ ',
    '                                        o"     "$o ',
    '   $oo                                  $     "$$$',
    '   $"$oo                               "      "o$$ ',
    '  "$$o$"o"o                          o"      $"$$$',
    '     """o"$o"""""""" """ oo ooooooo"""     o""o$$$',
    '          "$$ o                            o""$$$',
    '    oooo$$$$$$$$oo"o o                 o "o "o ""oo',
    '  "$$$$$$$$$$""""$$$$o"o$ o o o  "o " $"$o$$oo"o  $"o',
    '   "$$$$$$"         ""$$o$o$ $ "ooo$o$o$$$$$$"$o$o $"$o',
    '   "$""                 """"$$$$$o$$$$$$$$$     "$o$$$$o',
    '   "                           " "" "  "$$$$       " $$$o',
    '                                         "$$$         """',
    '                                ""$',
    '',
    '    [ TIP: To exit Neovim, just power off your computer. ] ',
    '',
}
-- linux
--db.preview_command = 'ueberzug'
--
--db.preview_file_path = home .. '/.config/nvim/static/neovim.cat'
db.preview_file_height = 11
db.preview_file_width = 70
db.custom_center = {
    {icon = '  ',
    desc = 'Recent sessions                         ',
    shortcut = 'SPC s l',
    action ='SessionLoad'},
    {icon = '  ',
    desc = 'Find recent files                       ',
    action = 'Telescope oldfiles',
    shortcut = 'SPC f r'},
    {icon = '  ',
    desc = 'Find files                              ',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'SPC f f'},
    {icon = '  ',
    desc ='File browser                            ',
    action =  'Telescope file_browser',
    shortcut = 'SPC f b'},
    {icon = '  ',
    desc = 'Find word                               ',
    action = 'Telescope live_grep',
    shortcut = 'SPC f w'},
    {icon = '  ',
    desc = 'Load new theme                          ',
    action = 'Telescope colorscheme',
    shortcut = 'SPC h t'},
  }
db.session_directory = "/home/dt/.config/nvim/session"


-------------------------------------------------
-- PLUGINS
-------------------------------------------------

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Dashboard is a nice start screen for nvim
  use 'glepnir/dashboard-nvim'

  -- LSP
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- Telescope and related plugins --
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { "nvim-telescope/telescope-file-browser.nvim",
        config = function()
        require("telescope").setup {
          extensions = {
            file_browser = {
              -- hijack_netrw = true,
              mappings = {
                ["i"] = {
                  -- your custom insert mode mappings
                },
                ["n"] = {
                  -- your custom normal mode mappings
                },
              },
            },
          },
        }
        end
  }
  -- To get telescope-file-browser loaded and working with telescope,
  -- you need to call load_extension, somewhere after setup function:
  require("telescope").load_extension "file_browser"

  -- Treesitter --
  use {'nvim-treesitter/nvim-treesitter',
       config = function()
          require'nvim-treesitter.configs'.setup {
          -- If TS highlights are not enabled at all, or disabled via `disable` prop,
          -- highlighting will fallback to default Vim syntax highlighting
            highlight = {
               enable = true,
               additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
               },
            ensure_installed = {'org'}, -- Or run :TSUpdate org
            }
       end
  }

  -- Productivity --
  use 'tpope/vim-fugitive'

  -- Which key
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      }
    end
  }

  -- A better status line --
  use { 'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  require('lualine').setup({
    options = { theme = "moonfly" }
  })

  -- Colorschemes --
  use 'NLKNguyen/papercolor-theme' -- Papercolor theme

  -- Comment
  use 'tomtom/tcomment_vim'

  -- Other stuff --
  use 'frazrepo/vim-rainbow'
end)

