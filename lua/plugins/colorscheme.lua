-- Активная тема задаётся ОДНОЙ строкой: LazyVim.opts.colorscheme (в самом низу файла).
-- Всё остальное здесь — только установка плагинов тем.
-- Не ставь lazy = false / priority = 1000: LazyVim грузит активную тему сам,
-- а неактивные не должны попадать в старт.
return {
  -- Tokyonight (folke) — активная
  {
    "folke/tokyonight.nvim",
    -- ВАЖНО: style живёт внутри opts. На верхнем уровне спека lazy.nvim
    -- его молча игнорирует — именно поэтому раньше работал "moon", а не "night".
    opts = { style = "night" }, -- варианты: night | storm | moon | day
  },

  -- Запасные темы. Чтобы вернуть любую: раскомментируй её блок здесь
  -- и поменяй colorscheme в самом низу файла.
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
