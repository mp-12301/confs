-- returns the require for use in `config` parameter of lazy's use
-- expects the name of the config file
function get_setup(name)
  return function()
    require("setup." .. name)
  end
end

return {
  -- Themes
  { "rebelot/kanagawa.nvim", config = get_setup("themes/kanagawa"), priority = 1000, lazy = false },

  -- Code
  {
    "nvim-treesitter/nvim-treesitter",
    config = get_setup("treesitter"),
    build = ":TSUpdate",
    event = "BufReadPost",
  },
    {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = get_setup("conform"),
    -- install prettierd, its faster
  },
  {
    "neovim/nvim-lspconfig",
    config = get_setup("lsp"),
    dependencies = { "saghen/blink.cmp" },
    -- don't forget to install the actual LSPs
  },
	{
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    opts = require("setup.blink"),
  },

  -- File Explorer
  { "stevearc/oil.nvim", event = "VeryLazy", config = get_setup("oil") },
  { "echasnovski/mini.bracketed", version = false },

  -- Status Bar
  {
    "nvim-lualine/lualine.nvim",
    config = get_setup("lualine"),
    event = "VeryLazy",
  },

  -- Packs with many plugins
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = require("setup.snacks"),
  },

  -- Finder
    {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = get_setup("fzf"),
  },
}
