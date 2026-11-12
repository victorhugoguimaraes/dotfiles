return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        continuous = 1,
        options = { "-verbose", "-file-line-error", "-synctex=1", "-interaction=nonstopmode" },
      }
      -- O Evince já está instalado e recarrega o PDF quando ele é recompilado.
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "evince"
      vim.g.vimtex_view_general_options = "@pdf"
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_compiler_silent = 1
      local group = vim.api.nvim_create_augroup("EscritaLatex", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "VimtexEventInitPost",
        callback = function(event)
          local buf = event.buf
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].filetype == "tex" then
              vim.api.nvim_buf_call(buf, function()
                local state = vim.b.vimtex
                if
                  state
                  and vim.fn.filereadable(state.tex) == 1
                  and vim.fn.eval("b:vimtex.compiler.is_running() ? 1 : 0") == 0
                then
                  vim.fn["vimtex#compiler#start"]()
                end
              end)
            end
          end)
        end,
      })
    end,
    keys = {
      { "<leader>lc", "<cmd>VimtexCompile<cr>", ft = "tex", desc = "LaTeX: iniciar/parar compilação" },
      { "<leader>lv", "<cmd>VimtexView<cr>", ft = "tex", desc = "LaTeX: abrir PDF" },
      { "<leader>le", "<cmd>VimtexErrors<cr>", ft = "tex", desc = "LaTeX: ver erros" },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" },
    opts = {
      heading = { sign = false },
      code = { sign = false, width = "block", right_pad = 1 },
      latex = { enabled = false },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    build = function()
      require("lazy").load({ plugins = { "markdown-preview.nvim" } })
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.g.mkdp_auto_close = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_page_title = "${name} — Anotações"
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Markdown: preview no navegador" },
      { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Markdown: alternar visualização" },
    },
  },
}
