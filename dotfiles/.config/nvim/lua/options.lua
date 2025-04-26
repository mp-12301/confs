local indent = 2
local opt = vim.opt -- to set options

opt.number = true
opt.relativenumber = true

opt.cursorline = true
opt.cursorcolumn = true
-- opt.cursorlineopt = "both"

opt.encoding = "utf-8" -- Set default encoding to UTF-8
opt.listchars = { tab = " ", trail = "·", nbsp = "%" }
opt.list = true
opt.incsearch = true -- Shows the match while typing

opt.expandtab = true
opt.shiftwidth = indent
opt.softtabstop = indent
opt.tabstop = indent

opt.scrolloff = 8
opt.sidescrolloff = 8

opt.spelllang = { "en_gb" }

opt.signcolumn = "yes:1"

opt.termguicolors = true -- You will have bad experience for diagnostic messages when it's default 4000.
opt.title = true -- Allows neovom to send the Terminal details of the current window, instead of just getting 'v'

opt.mouse = "a"

opt.guicursor = "n-v-c-sm:block-nCursor-blinkwait50-blinkon50-blinkoff50,i-ci-ve:ver25-Cursor-blinkon100-blinkoff100,r-cr-o:hor20"

opt.undofile = true

opt.cmdheight = 0

local api = vim.api;

local yankGrp = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  group = yankGrp,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight yank",
})

-- This is global settings for diagnostics
vim.o.updatetime = 250
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
  -- virtual_lines = {
  --   current_line = true,
  -- },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰳦 ",
      [vim.diagnostic.severity.HINT] = "󱡄 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
})
