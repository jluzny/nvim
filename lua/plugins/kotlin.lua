if true or vim.g.vscode then
  return {}
end

return {
  --  Kotlion setup
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "kotlin",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_language_server = {},
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "kotlin-debug-adapter" })
        end,
      },
    },
    opts = function(_, opts)
      local dap = require("dap")
      dap.configurations.kotlin = {
        {
          type = "kotlin",
          name = "launch - kotlin",
          request = "attach",
          hostName = "127.0.0.1",
          port = 5005,
          timeout = 5000,
          --projectRoot = vim.fn.getcwd(),
          projectRoot = "${workspaceFolder}",
          -- mainClass = "example.micronaut.ApplicationKt",
          -- mainClass = function()
          --   return vim.fn.input("Path to main class > ", "example.micronaut.ApplicationKt", "file")
          --   -- return vim.fn.input("Path to main class > ", "", "file")
          -- end,
        },
      }
    end,
  },
}
