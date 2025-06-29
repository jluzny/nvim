if vim.g.vscode then
  return {}
else
  return {
    import = "lazyvim.plugins.extras.lang.python",
  }
end

return {
  -- { import = "lazyvim.plugins.extras.lang.python-semshi" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        ruff_lsp = {},
      },
    },
    setup = {
      ruff_lsp = function()
        require("lazyvim.util").on_attach(function(client, _)
          if client.name == "ruff_lsp" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end)
      end,
    },
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          -- runner = "pytest",
          -- python = ".venv/bin/python",
        },
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      -- stylua: ignore
      keys = {
        { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method" },
        { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class" },
      },
      config = function()
        local path = require("mason-registry").get_package("debugpy"):get_install_path()
        require("dap-python").setup(path .. "/venv/bin/python")
      end,
    },
  },

  {
    "linux-cultist/venv-selector.nvim",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap-python",
    },
    cmd = "VenvSelect",
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
    opts = {
      dap_enabled = true,
      name = { "venv", ".venv" },
    },
  },

  -- Setup null-ls with `black`
  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("none-ls")
  --     opts.sources = vim.list_extend(opts.sources, {
  --       -- Order of formatters matters. They are used in order of appearance.
  --       -- nls.builtins.diagnostics.ruff,
  --       -- nls.builtins.diagnostics.ruff.with({
  --       --   args = { "--ignore", "E501" },
  --       -- }),
  --       -- nls.builtins.formatting.black,
  --       nls.builtins.formatting.black.with({
  --         extra_args = { "--line-length", "120" },
  --       }),
  --     })
  --   end,
  -- },
}
