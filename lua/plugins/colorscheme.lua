return {
  -- Nightfox theme
  {
    "EdenEast/nightfox.nvim",
    lazy = false, -- load immediately
    priority = 1000, -- load before other plugins
    opts = {
      -- optional settings
      options = {
        transparent = false,
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- load immediately
    priority = 1000, -- load before other plugins
  },
  {
    "nickkadutskyi/jb.nvim",
    lazy = false, -- load immediately
    priority = 1000, -- load before other plugins
  },
  {
    "folke/tokyonight.nvim",
    lazy = false, -- load immediately
    priority = 1000, -- load before other plugins
    style = "night",
  },
  -- Tell LazyVim to use Nightfox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
