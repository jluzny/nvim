if vim.g.vscode then
  return {}
end

return {
  -- { import = "lazyvim.plugins.extras.lang.elixir" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "elixir",
        "heex",
        "eex",
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "elixir-ls",
        -- "lexical",
      })
      -- Disable autostart for elixirls
      -- require("mason-lspconfig").setup_handlers({
      --   ["elixirls"] = function()
      --     require("lspconfig").elixirls.setup({
      --       autostart = false,
      --     })
      --   end,
      -- })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = {
        elixir = { "credo" },
      }

      opts.linters = {
        credo = {
          condition = function(ctx)
            return vim.fs.find({ ".credo.exs" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      }
    end,
  },

  {
    "jfpedroza/neotest-elixir",
  },

  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "jfpedroza/neotest-elixir",
    },
    opts = {
      adapters = {
        ["neotest-elixir"] = {},
      },
      quickfix = { open = false },
    },
  },

  {
    "mfussenegger/nvim-dap",
    opts = function(_, opts)
      local dap = require("dap")
      if not dap.adapters["mix_task"] then
        dap.adapters["mix_task"] = {
          type = "executable",
          -- command = vim.fn.stdpath("config") .. "/lua/plugins/elixir_debug_adapter.sh",
          command = vim.fn.stdpath("data") .. "/mason/bin/elixir-ls-debugger",
          args = {},
        }
      end

      for _, language in ipairs({ "elixir" }) do
        dap.configurations[language] = {
          {
            type = "mix_task",
            name = "Generic Test",
            task = "test",
            taskArgs = { "--trace" },
            request = "launch",
            exitAfterTaskReturns = false,
            debugAutoInterpretAllModules = false,
            startApps = false,
            projectDir = "${workspaceFolder}",
            requireFiles = {
              "test/**/test_helper.exs",
              "test/**/*_test.exs",
            },
          },
          -- {
          --   type = "mix_task",
          --   name = "Generic Phx.server",
          --   task = "phx.server",
          --   -- taskArgs = { "--trace", "${file}" },
          --   -- exitAfterTaskReturns = false,
          --   request = "launch",
          --   projectDir = "${workspaceFolder}",
          --   startApps = true,
          -- },
          -- {
          --   type = "mix_task",
          --   name = "gleam test",
          --   task = "gleam.test",
          --   taskArgs = { "--trace" },
          --   request = "launch",
          --   projectDir = "${workspaceFolder}",
          -- },
        }
      end
    end,
  },
}
