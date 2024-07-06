if true or vim.g.vscode then
  return {}
end

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.dia, {
        "elixir-ls",
        -- "lexical",
      })
    end,
  },

  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup({
        nextls = {
          enable = false,
          init_options = {
            experimental = {
              completions = {
                enable = true, -- control if completions are enabled. defaults to false
              },
            },
          },
        },
        credo = { enable = true },
        elixirls = {
          enable = true,
          cmd = { "elixir-ls" },
          settings = elixirls.settings({
            dialyzerEnabled = true,
            enableTestLenses = true,
            suggestSpecs = true,
          }),
        },
      })
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
      -- quickfix = { open = false },
    },
  },

  {
    "mfussenegger/nvim-dap",
    opts = function(_, opts)
      local dap = require("dap")
      if not dap.adapters["mix_task"] then
        dap.adapters["mix_task"] = {
          type = "executable",
          command = vim.fn.stdpath("data") .. "/mason/bin/elixir-ls-debugger",
          args = {},
        }
      end

      for _, language in ipairs({ "elixir", "gleam" }) do
        dap.configurations[language] = {
          {
            type = "mix_task",
            name = "mix test",
            task = "test",
            taskArgs = { "--trace" },
            request = "launch",
            projectDir = "${workspaceFolder}",
            requireFiles = {
              "test/**/test_helper.exs",
              "test/**/*_test.exs",
            },
          },
          -- {
          --   type = "mix_task",
          --   name = "mix phx.server",
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
