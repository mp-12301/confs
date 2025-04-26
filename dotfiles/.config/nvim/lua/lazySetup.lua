-- returns the require for use in `config` parameter of lazy's use
-- expects the name of the config file
function get_setup(name)
  return function()
    require("setup." .. name)
  end
end

return {
  { "rebelot/kanagawa.nvim", config = get_setup("themes/kanagawa"), priority = 1000, lazy = false },
  {
    "nvim-treesitter/nvim-treesitter",
    config = get_setup("treesitter"),
    build = ":TSUpdate",
    event = "BufReadPost",
  },
  { "stevearc/oil.nvim", event = "VeryLazy", config = get_setup("oil") },
  {
    "nvim-lualine/lualine.nvim",
    -- config = get_setup("lualine"),
    event = "VeryLazy",
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      indent = {
        -- your indent configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    }
  }
}
