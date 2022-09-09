local Remap = require("mp.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<C-t>", ":NERDTreeToggle <CR>")

vim.g.NERDTreeShowHidden = 1

vim.g.DevIconsAppendArtifactFix = 1
