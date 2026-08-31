return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = false },
    servers = {
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
