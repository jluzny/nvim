if vim.g.vscode or true then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "erlang" })
      end
    end,
  },

  {
    "neovim/nvim-lspconfig",
    init = function()
      require("lspconfig").erlangls.setup({})
    end,
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "erlang-debugger" })
        end,
      },
    },
    opts = function(_, opts)
      local dap = require("dap")
      if not dap.adapters["erlang"] then
        dap.adapters["erlang"] = {
          type = "executable",
          command = "els_dap",
          args = {},
        }
        dap.configurations.erlang = {
          {
            name = "erlang",
            type = "erlang",
            request = "launch",
            -- request = "attach",
            -- projectnode = "hello_world_example",
            -- cookie = "hello_world_example",
            -- timeout = "300",
            cwd = "${workspaceRoot}",
            -- projectDir = "${workspaceFolder}",
            -- requireFiles = {
            --   "test/**/test_helper.exs",
            --   "test/**/*_test.exs",
            -- },
          },
        }
      end
    end,
  },
}
