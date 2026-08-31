-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.guifont = "JetBrainsMono Nerd Font:h16"

-- Отступы: expandtab / tabstop=2 / shiftwidth=2 уже стоят в дефолтах LazyVim,
-- дублировать их не нужно. Здесь только то, чего в дефолтах нет.
vim.o.softtabstop = 2

-- Inlay hints выключены; сам LSP-спек тоже это ставит (lua/plugins/lsp.lua).
vim.lsp.inlay_hint.enable(false)
