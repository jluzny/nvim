if vim.g.vscode then
  return {}
end

return {
  { import = "lazyvim.plugins.extras.lang.elixir" },

  -- {
  --   "mfussenegger/nvim-dap",
  --   dependencies = {
  --     {
  --       "williamboman/mason.nvim",
  --       opts = function(_, opts)
  --         opts.ensure_installed = opts.ensure_installed or {}
  --         vim.list_extend(opts.ensure_installed, { "elixir-ls" })
  --       end,
  --     },
  --   },
  --   opts = function(_, opts)
  --     local dap = require("dap")
  --     if not dap.adapters["mix_task"] then
  --       dap.adapters["mix_task"] = {
  --         type = "executable",
  --         command = vim.fn.stdpath("data") .. "/mason/bin/elixir-ls-debugger",
  --         args = {},
  --       }
  --     end
  --
  --     for _, language in ipairs({ "elixir", "erlang", "gleam" }) do
  --       dap.configurations[language] = {
  --         {
  --           type = "mix_task",
  --           name = "mix test",
  --           task = "test",
  --           taskArgs = { "--trace" },
  --           request = "launch",
  --           projectDir = "${workspaceFolder}",
  --           requireFiles = {
  --             "test/**/test_helper.exs",
  --             "test/**/*_test.exs",
  --           },
  --         },
  --         {
  --           type = "mix_task",
  --           name = "gleam test",
  --           task = "gleam.test",
  --           taskArgs = { "--trace" },
  --           request = "launch",
  --           projectDir = "${workspaceFolder}",
  --           -- requireFiles = {
  --           --   "test/**/test_helper.erl",
  --           --   "test/**/*_test.erl",
  --           -- },
  --         },
  --       }
  --     end
  --   end,
  -- },
}
