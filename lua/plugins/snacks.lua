return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      -- Глобальный матчер для всех НЕ-live источников: files, git_files,
      -- buffers, recent, smart и т.д. Задан явно, чтобы поведение поиска
      -- не зависело от того, что там меняется в дефолтах snacks.
      matcher = {
        fuzzy = true, -- нестрогий поиск: "web/pkg" находит apps/web/package.json
        smartcase = true, -- строчные буквы игнорируют регистр, заглавные - нет
        ignorecase = true,
        filename_bonus = true, -- совпадение в имени файла весит больше, чем в пути
      },
      sources = {
        -- grep - live-источник: запрос уходит прямо в ripgrep, поэтому
        -- fuzzy к нему не применяется. Раньше здесь стоял regex = false,
        -- то есть rg --fixed-strings - ровно тот "поиск только точных
        -- вхождений". Теперь работают обычные regex: web.*package, foo|bar.
        grep = {
          regex = true,
        },
      },
    },
  },
}
