return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      on_highlights = function(hl, _)
        require("config.darcula").apply(hl)
      end,

      on_colors = function(colors)
        require("config.darcula").apply_background(colors)
      end,
    },
  },

  -- { "EdenEast/nightfox.nvim", opts = { options = { transparent = false } } },
  -- { "rebelot/kanagawa.nvim" },
  -- { "nickkadutskyi/jb.nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
      -- colorscheme = "nightfox",
      -- colorscheme = "kanagawa",
      -- colorscheme = "jb",
    },
  },
}
