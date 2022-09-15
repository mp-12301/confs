local Remap = require("mp.keymap")
local nnoremap = Remap.nnoremap

nnoremap("<leader>gl", ":G difftool<CR>")
nnoremap("<leader>gd", ":Gdiffsplit<CR>")
