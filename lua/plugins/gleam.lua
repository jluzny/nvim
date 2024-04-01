if vim.g.vscode then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "gleam" })
      end

      -- vim.keymap.set({ "n", "i" }, "<C-S>", "<cmd>wa | make<cr>", { desc = "Save and make the file" })
    end,
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       gleam = {},
  --     },
  --   },
  -- },

  {
    "neovim/nvim-lspconfig",
    init = function()
      require("lspconfig").gleam.setup({ cmd = { "glas", "--stdio" } })
    end,
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   event = "VeryLazy",
  --   ft = "gleam",
  --   init = function()
  --     require("lspconfig").gleam.setup({ cmd = { "glas", "--stdio" } })
  --     vim.keymap.set({ "n", "i" }, "<C-S>", "<cmd>wa | make<cr>", { desc = "Save and make the file" })
  --   end,
  -- },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      languages = {
        gleam = "// %s",
      },
    },
  },

  -- {
  --   "NTBBloodbath/zig-tools.nvim",
  --   Event = "VeryLazy",
  --   ft = "gleam",
  --   dependencies = {
  --     {
  --       "akinsho/toggleterm.nvim",
  --     },
  --   },
  --   config = function(_, opts)
  --     vim.keymap.set({ "n", "i" }, "<C-S>", "<cmd>wa | make!<cr>", { desc = "Save and make the file" })
  --   end,
  -- },
}
