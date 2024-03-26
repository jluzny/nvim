if vim.g.vscode then
  return {}
end

return {
  { import = "lazyvim.plugins.extras.lang.elixir" },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "elixir-ls" })
        end,
      },
    },
    opts = function(_, opts)
      local dap = require("dap")
      if not dap.adapters["mix_task"] then
        dap.adapters["mix_task"] = {
          type = "executable",
          command = vim.fn.stdpath("data") .. "/mason/bin/elixir-ls-debugger",
          args = {},
        }
        dap.configurations.elixir = {
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
        }
      end
    end,
  },
  -- {
  --   "elixir-tools/elixir-tools.nvim",
  --   version = "*",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     local elixir = require("elixir")
  --     local elixirls = require("elixir.elixirls")
  --
  --     elixir.setup({
  --       nextls = { enable = false },
  --       credo = {},
  --       elixirls = {
  --         enable = true,
  --         settings = elixirls.settings({
  --           dialyzerEnabled = true,
  --           enableTestLenses = true,
  --         }),
  --         on_attach = function(client, bufnr)
  --           vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
  --           vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
  --           vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
  --         end,
  --       },
  --     })
  --   end,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },
}
