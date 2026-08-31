-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Copy absolute path of current file to system clipboard
vim.keymap.set("n", "<leader>yp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  vim.notify("Copied path: " .. vim.fn.expand("%:p"))
end, { desc = "Yank file path (absolute)" })

-- LazyVim user keymaps
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })

-- <leader>ff / fg / fb / fh намеренно НЕ переопределяются здесь:
-- это дефолты LazyVim, они идут в snacks.picker (единственный пикер в конфиге).

-- Text-based "find usages" fallback: grep the word/selection across the project.
-- Useful for things the LSP can't resolve (JSX tags in untyped files, dynamic
-- imports, CSS classes, config keys, strings).
vim.keymap.set("n", "<leader>fu", function()
  Snacks.picker.grep_word({ regex = false })
end, { desc = "Find usages (grep word under cursor)" })

vim.keymap.set("x", "<leader>fu", function()
  Snacks.picker.grep_word({ regex = false })
end, { desc = "Find usages (grep selection)" })
