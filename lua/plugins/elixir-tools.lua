if true or vim.g.vscode then
  return {}
end

return {
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")

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
        elixirls = { enable = true, cmd = { "elixir-ls" } },
      })
    end,
  },
}
