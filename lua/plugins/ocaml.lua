if vim.g.vscode then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ocaml" })
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    -- opts = {
    --   servers = {
    --     ocamllsp = {},
    --   },
    --   inlay_hints = {
    --     enabled = true,
    --   },
    -- },

    init = function()
      require("lspconfig").ocamllsp.setup({
        settings = {
          codelens = { enable = true },
          extendedHover = { enable = true },
          duneDiagnostics = { enable = true },
          inlayHints = { enable = true },
        },
      })
    end,
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "ocamlearlybird" })
        end,
      },
    },
    opts = function(_, opts)
      local dap = require("dap")
      if not dap.adapters["ocaml.earlybird"] then
        dap.adapters["ocaml.earlybird"] = {
          type = "executable",
          command = "ocamlearlybird",
          args = { "debug" },
        }
        dap.configurations.ocaml = {
          {
            name = "ocaml.earlybird",
            type = "ocaml.earlybird",
            console = "integratedTerminal",
            request = "launch",
            stopOnEntry = false,
            program = "_build/default/${relativeFileDirname}/${fileBasenameNoExtension}.bc",
            cwd = "${workspaceFolder}",
            onlyDebugGlob = "<${workspaceRoot}/**/*>",
            yieldSteps = 4096,
          },
        }
      end
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ocaml = { "ocamlformat" },
      },
    },
  },
}
