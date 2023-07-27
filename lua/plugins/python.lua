return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "mfussenegger/nvim-dap-python",
    },
    opts = {
      dap_enabled = true,
      name = { "venv", ".venv" },
    },
    event = "VeryLazy",
  },

  -- Setup null-ls with `black`
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        -- Order of formatters matters. They are used in order of appearance.
        nls.builtins.formatting.black,
        nls.builtins.formatting.black.with({
          extra_args = { "--line-length", "120" },
        }),
        -- nls.builtins.diagnostics.ruff,
      })
    end,
  },
}
