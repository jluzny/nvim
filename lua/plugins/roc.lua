if vim.g.vscode then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.filetype.add({
        pattern = {
          [".*%.roc"] = "roc",
        },
      })

      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "roc" })
      end
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        roc = { "roc format" },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    init = function()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig.configs")

      if not configs.roc_lsp then
        configs.roc_lsp = {
          default_config = {
            cmd = { "roc_language_server" },
            root_dir = lspconfig.util.root_pattern(".git"),
            filetypes = { "roc" },
          },
        }
      end
      lspconfig.roc_lsp.setup({})
    end,
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      languages = {
        roc = "# %s",
      },
    },
  },
}
