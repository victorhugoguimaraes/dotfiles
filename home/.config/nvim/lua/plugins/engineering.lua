return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Os servidores só iniciam quando você abre a linguagem correspondente.
      inlay_hints = { enabled = false },
      servers = {
        clangd = {
          cmd = { "clangd", "--background-index", "--header-insertion=never", "-j=2" },
        },
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = false },
              checkOnSave = true,
            },
          },
        },
        pyright = {},
        vtsls = {},
        aiken = {},
        texlab = {
          settings = { texlab = { build = { onSave = false } } },
        },
        marksman = {},
      },
    },
  },
  {
    "aiken-lang/editor-integration-nvim",
    init = function()
      vim.filetype.add({ extension = { ak = "aiken" } })
    end,
    ft = "aiken",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "c", "cpp", "rust" })
    end,
  },
}
