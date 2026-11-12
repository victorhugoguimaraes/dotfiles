local M = {}

function M.toggle()
  if M.terminal and M.terminal:buf_valid() then
    return M.terminal:toggle()
  end
  if vim.fn.executable("codex") ~= 1 then
    vim.notify("Codex CLI não foi encontrado no PATH.", vim.log.levels.ERROR)
    return
  end
  -- A raiz do projeto mantém o Codex no mesmo contexto dos arquivos abertos.
  M.terminal = Snacks.terminal.open({ "codex" }, {
    cwd = LazyVim.root(),
    win = { position = "right", width = 0.45, border = "rounded" },
  })
  return M.terminal
end

return M
