if vim.g.vscode then
  return {}
end

return {
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup({
        nextls = {
          enable = true,
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
            dialyzerEnabled = false,
            enableTestLenses = false,
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
    },
  },
}
