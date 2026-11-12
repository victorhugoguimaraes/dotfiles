local M = {}
local timers = {}

local function cancel(buf)
  local timer = timers[buf]
  if timer then
    timers[buf] = nil
    timer:stop()
    timer:close()
  end
end

local function writable(buf)
  if not vim.api.nvim_buf_is_loaded(buf) then
    return false
  end
  local opts = vim.bo[buf]
  local name = vim.api.nvim_buf_get_name(buf)
  return opts.filetype == "tex"
    and opts.buftype == ""
    and opts.modifiable
    and not opts.readonly
    and opts.modified
    and vim.fn.getftype(name) == "file"
    and vim.fn.filewritable(name) == 1
end

local function schedule(buf)
  cancel(buf)
  if not vim.g.latex_autosave_enabled or not writable(buf) then
    return
  end
  local tick = vim.api.nvim_buf_get_changedtick(buf)
  local timer = assert(vim.uv.new_timer())
  timers[buf] = timer
  timer:start(
    1500,
    0,
    vim.schedule_wrap(function()
      if timers[buf] ~= timer then
        return
      end
      cancel(buf)
      if not vim.g.latex_autosave_enabled or not writable(buf) or vim.api.nvim_buf_get_changedtick(buf) ~= tick then
        return
      end
      local ok, err = pcall(vim.api.nvim_buf_call, buf, function()
        vim.cmd("silent update")
      end)
      if not ok then
        vim.notify("Não foi possível salvar o LaTeX: " .. tostring(err), vim.log.levels.WARN)
      end
    end)
  )
end

function M.setup()
  if vim.g.latex_autosave_enabled == nil then
    vim.g.latex_autosave_enabled = true
  end
  local group = vim.api.nvim_create_augroup("LatexAutoSave", { clear = true })
  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "TextChangedP" }, {
    group = group,
    callback = function(event)
      schedule(event.buf)
    end,
  })
  vim.api.nvim_create_autocmd({ "BufUnload", "BufWipeout", "BufWritePost" }, {
    group = group,
    callback = function(event)
      cancel(event.buf)
    end,
  })
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = group,
    callback = function()
      for _, buf in ipairs(vim.tbl_keys(timers)) do
        cancel(buf)
      end
    end,
  })
  vim.api.nvim_create_user_command("LatexAutoSaveToggle", function()
    vim.g.latex_autosave_enabled = not vim.g.latex_autosave_enabled
    for _, buf in ipairs(vim.tbl_keys(timers)) do
      cancel(buf)
    end
    if vim.g.latex_autosave_enabled then
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        schedule(buf)
      end
    end
    vim.notify("Salvamento automático LaTeX " .. (vim.g.latex_autosave_enabled and "ativado" or "pausado"))
  end, { desc = "Ativar ou pausar o salvamento automático de LaTeX" })
end

return M
