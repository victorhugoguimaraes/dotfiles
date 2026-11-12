-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>ac", function()
  require("config.codex").toggle()
end, { desc = "Codex: abrir/ocultar terminal lateral" })

vim.api.nvim_create_user_command("Codex", function()
  require("config.codex").toggle()
end, { desc = "Abrir/ocultar Codex CLI ao lado do editor" })

vim.api.nvim_create_user_command("EscritaAjuda", function()
  vim.cmd.edit(vim.fn.expand("~/Documentos/Guia-Neovim.md"))
end, { desc = "Abrir guia de LaTeX, Markdown e Codex" })
