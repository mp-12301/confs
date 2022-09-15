local nnoremap = require("mp.keymap").nnoremap

nnoremap("<leader>pv", "<cmd>Ex<CR>")

nnoremap("<leader><tab>", "<C-^><CR>")

nnoremap("<leader>j", ":cnext<CR>")
nnoremap("<leader>k", ":cprev<CR>")
nnoremap("<leader>o", ":copen<CR>")
nnoremap("<leader>c", ":cclose<CR>")
