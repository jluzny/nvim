if vim.g.vscode then
  return {}
end

return {
  {
    "mrcjkb/haskell-tools.nvim",
    Event = "VeryLazy",
    version = "^3", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
    config = function(_, opts)
      vim.g.haskell_tools = {
        -- tools = {
        --   -- ...
        -- },
        -- hls = {
        --   on_attach = function(client, bufnr, ht)
        --     -- Set keybindings, etc. here.
        --   end,
        --   -- ...
        -- },
        dap = {
          -- ...
        },
      }
    end,
  },
}
