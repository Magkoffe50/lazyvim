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
      -- Показывать в поиске файлы из .gitignore и dotfiles (.env и т.п.).
      -- node_modules и .git отрезаны отдельно: без этого ignored = true
      -- затягивает десятки тысяч файлов и поиск становится бесполезным.
      -- Разово переключается прямо в пикере: <a-i> - ignored, <a-h> - hidden.
      hidden = true,
      ignored = true,
      exclude = { "node_modules", ".git" },

      sources = {
        -- У source "files" в дефолтах snacks свои hidden = false /
        -- ignored = false, и они перекрывают глобальные выше - поэтому
        -- здесь их нужно повторить явно, иначе <leader>ff и <leader><leader>
        -- продолжат прятать gitignored-файлы.
        files = {
          hidden = true,
          ignored = true,
        },

        -- grep - live-источник: запрос уходит прямо в ripgrep, поэтому
        -- fuzzy к нему не применяется. Раньше здесь стоял regex = false,
        -- то есть rg --fixed-strings - ровно тот "поиск только точных
        -- вхождений". Теперь работают обычные regex: web.*package, foo|bar.
        grep = {
          regex = true,
        },

        -- Пустая модалка "Lsp Definitions 0/0" - это не ошибка, а гонка:
        -- snacks открывает окно, если источник не ответил за show_delay,
        -- и после этого уже не может показать обычное "No results".
        -- Медленный первый ответ tsserver в монорепе укладывался в 5 секунд
        -- дефолта, поэтому окно и выскакивало пустым.
        lsp_definitions = { show_delay = 20000 },
        lsp_type_definitions = { show_delay = 20000 },
        lsp_declarations = { show_delay = 20000 },
        lsp_implementations = { show_delay = 20000 },
        lsp_references = { show_delay = 20000 },
      },
    },
  },
}
