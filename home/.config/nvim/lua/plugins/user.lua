return {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = {
      style = "dark",
      transparent = false,
      highlights = {
        Comment = { italic = true },
      },
    },
    config = function(_, opts)
      require("onedark").setup(opts)
      require("onedark").load()
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },

  -- Explorador de arquivos leve, acessível com <leader>e.
  {
    "stevearc/oil.nvim",
    opts = {},
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "Abrir explorador de arquivos" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Parsers úteis para os arquivos mais comuns.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "css",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      })
    end,
  },

  -- Ferramentas instaladas automaticamente pelo Mason.
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "prettier",
        "shfmt",
      },
    },
  },

  -- Formatação ao salvar; o LazyVim já configura conform.nvim.
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        sh = { "shfmt" },
        bash = { "shfmt" },
      },
    },
  },
}
