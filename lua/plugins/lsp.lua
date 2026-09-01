return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      -- Большая TS-монорепа: tsserver по умолчанию получает 3072 МБ и на
      -- первом запросе (gd/gr) может думать дольше, чем snacks ждёт ответа
      -- (show_delay = 5000 мс) - тогда выскакивает пустое окно пикера "0/0".
      vtsls = {
        settings = {
          typescript = {
            tsserver = {
              maxTsServerMemory = 8192,
            },
          },
        },
      },

      -- keymaps for every LSP server
      ["*"] = {
        -- stylua: ignore
        keys = {
          -- Find all usages (fuzzy picker with live preview)
          { "gr", function() Snacks.picker.lsp_references({ include_declaration = false }) end,
            desc = "References (usages)", nowait = true, has = "references" },

          -- Find all usages in a persistent IDE-style panel (grouped by file)
          { "<leader>cu", "<cmd>Trouble lsp_references toggle focus=true<cr>",
            desc = "Usages (Trouble panel)", has = "references" },

          -- Everything about the symbol at once: refs + defs + impls + type defs
          { "<leader>cU", "<cmd>Trouble lsp toggle focus=true win.position=right<cr>",
            desc = "Usages + defs (Trouble sidebar)" },

          -- Jump through usages inside the current file without opening anything
          { "]u", function() Snacks.words.jump(vim.v.count1, true) end, desc = "Next usage in file" },
          { "[u", function() Snacks.words.jump(-vim.v.count1, true) end, desc = "Prev usage in file" },
        },
      },
    },
  },
}
