-- # Common Mappings
local km = vim.keymap

-- Here is a utility function that closes any floating windows when you press escape
local function close_floating()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "win" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

km.set("n", "<Leader>n", "<cmd>enew<CR>", { desc = "New File" })

km.set("n", "<Leader>a", "ggVG<c-$>", { desc = "Select All" })

km.set("v", "y", "ygv<Esc>", { desc = "Yank and reposition cursor" })

-- More molecular undo of text
km.set("i", ".", ".<c-g>u")
km.set("i", "!", "!<c-g>u")
km.set("i", "?", "?<c-g>u")
km.set("i", ";", ";<c-g>u")
km.set("i", ":", ":<c-g>u")

km.set("n", "<esc>", function()
  close_floating()
  vim.cmd(":noh")
end, { silent = true, desc = "Remove Search Highlighting, Dismiss Popups" })

-- Easy add date/time
function date()
  local pos = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local nline = line:sub(0, pos) .. "# " .. os.date("%d.%m.%y") .. line:sub(pos + 1)
  vim.api.nvim_set_current_line(nline)
  vim.api.nvim_feedkeys("o", "n", true)
end

km.set("n", "<Leader>xd", "<cmd>lua date()<cr>", { desc = "Insert Date" })

km.set("n", "<Leader>v", "gea", { desc = "Edit after last word" })

km.set("n", "<leader>ch", function()
  vim.lsp.buf.hover()
end, { desc = "Code Hover" })

km.set("n", "<leader>cl", function()
  vim.diagnostic.open_float(0, { scope = "line" })
end, { desc = "Line Diagnostics" })

km.set({ "v", "n" }, "<leader>cn", function()
  vim.lsp.buf.rename()
end, { noremap = true, silent = true, desc = "Code Rename" })

-- Easier window switching with leader + Number
-- Creates mappings like this: km.set("n", "<Leader>2", "2<C-W>w", { desc = "Move to Window 2" })
for i = 1, 4 do
  local lhs = "<Leader>" .. i
  local rhs = i .. "<C-W>w"
  km.set("n", lhs, rhs, { desc = "Move to Window " .. i })
end

-- ## Javascript Mappings
km.set("n", "<Leader>xc", ":g/console.lo/d<cr>", { desc = "Remove console.log" })

-- ## Git Mappings
km.set("n", "<leader>gf", ":! git checkout -- % <cr>", { silent = true, desc = "Chechout current file" })

-- # Plugins Mappings

-- ## Snacks Mapping
-- ### Toggle Terminal, thanks https://www.reddit.com/r/neovim/comments/1bjhadj/efficiently_switching_between_neovim_and_terminal/
exitTerm = function()
  vim.cmd(":lua Snacks.terminal.toggle()")
end
km.set({ "n" }, "<C-t>", ":lua Snacks.terminal.toggle()<cr>", { desc = "Toggle Terminal" })
km.set({ "t" }, "<C-t>", exitTerm)


-- ## Oil Mappings
km.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- ## fzf Mappings
km.set("n", "<leader>p", require("fzf-lua").files, { desc = "FZF Files" })

km.set("n", "<leader><leader>", require("fzf-lua").resume, { desc = "FZF Resume" })

km.set("n", "<leader>r", require("fzf-lua").registers, { desc = "Registers" })

km.set("n", "<leader>m", require("fzf-lua").marks, { desc = "Marks" })

km.set("n", "<leader>k", require("fzf-lua").keymaps, { desc = "Keymaps" })

km.set("n", "<leader>f", require("fzf-lua").live_grep, { desc = "FZF Grep" })

km.set("n", "<leader>b", require("fzf-lua").buffers, { desc = "FZF Buffers" })

km.set("v", "<leader>8", require("fzf-lua").grep_visual, { desc = "FZF Selection" })

km.set("n", "<leader>7", require("fzf-lua").grep_cword, { desc = "FZF Word" })

km.set("n", "<leader>j", require("fzf-lua").helptags, { desc = "Help Tags" })

km.set("n", "<leader>gc", require("fzf-lua").git_bcommits, { desc = "Browse File Commits" })

km.set("n", "<leader>gs", require("fzf-lua").git_status, { desc = "Git Status" })

km.set("n", "<leader>s", require("fzf-lua").spell_suggest, { desc = "Spelling Suggestions" })

km.set("n", "<leader>cj", require("fzf-lua").lsp_definitions, { desc = "Jump to Definition" })

km.set(
  "n",
  "<leader>cs",
  ":lua require'fzf-lua'.lsp_document_symbols({winopts = {preview={wrap='wrap'}}})<cr>",
  { desc = "Document Symbols" }
)

km.set("n", "<leader>cr", require("fzf-lua").lsp_references, { desc = "LSP References" })

km.set(
  "n",
  "<leader>cd",
  ":lua require'fzf-lua'.diagnostics_document({fzf_opts = { ['--wrap'] = true }})<cr>",
  { desc = "Document Diagnostics" }
)

km.set(
  "n",
  "<leader>ca",
  ":lua require'fzf-lua'.lsp_code_actions({ winopts = {relative='cursor',row=1.01, col=0, height=0.2, width=0.4} })<cr>",
  { desc = "Code Actions" }
)

-- ## LSP mappings
km.set("n","gd", ":lua vim.lsp.buf.definition()<cr>", { desc = "Go to definition"} )
