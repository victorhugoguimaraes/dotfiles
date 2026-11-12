-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

require("config.latex_autosave").setup()

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("EscritaTexto", { clear = true }),
  pattern = { "tex", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
    vim.opt_local.conceallevel = vim.bo.filetype == "markdown" and 2 or 0
  end,
})
