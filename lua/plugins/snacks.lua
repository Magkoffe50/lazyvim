-- Нестрогий текстовый grep без регулярок со стороны пользователя.
--
-- Ввод считается ОБЫЧНЫМ ТЕКСТОМ: все спецсимволы регулярок экранируются,
-- поэтому "dispatch(", "arr[0]" и "a.*b" ищутся буквально. Пробел между
-- словами означает "что угодно между ними": "dispatch user" находит
-- dispatch(setUser(...)). Так поиск остаётся условным, но писать регулярки
-- не нужно и синтаксических ошибок ripgrep больше не бывает.
--
-- Побочный эффект: аргументы вида "-t lua" внутри запроса больше не
-- распознаются - они становятся частью искомого текста.
local function grep_pattern(search)
  local parts = {}
  for word in search:gmatch("%S+") do
    parts[#parts + 1] = (word:gsub("[\\%.%+%*%?%(%)%[%]%{%}%^%$|]", "\\%0"))
  end
  return table.concat(parts, ".*")
end

local function grep_finder(opts, ctx)
  local typed = ctx.filter.search or ""
  ctx.filter.search = grep_pattern(typed)
  local ok, finder = pcall(require("snacks.picker.source.grep").grep, opts, ctx)
  ctx.filter.search = typed
  if not ok then
    return function() end
  end
  return finder
end

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

        -- regex = true нужно, чтобы ripgrep не получил --fixed-strings:
        -- экранированием занимается grep_pattern выше, а ".*" между словами
        -- работает только в regex-режиме.
        grep = {
          regex = true,
          finder = grep_finder,
        },
        grep_buffers = {
          regex = true,
          finder = grep_finder,
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
