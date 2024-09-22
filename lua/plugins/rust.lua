if vim.g.vscode then
  return {}
end

return {
  { import = "lazyvim.plugins.extras.lang.rust" },

  -- {
  --   "mrcjkb/rustaceanvim",
  --   ft = { "rust" },
  --   opts = {
  --     server = {
  --       default_settings = {
  --         -- rust-analyzer language server configuration
  --         ["rust-analyzer"] = {
  --           -- Add clippy lints for Rust.
  --           procMacro = {
  --             enable = true,
  --             ignored = {
  --               ["async-trait"] = { "async_trait" },
  --               ["napi-derive"] = { "napi" },
  --               ["async-recursion"] = { "async_recursion" },
  --             },
  --           },
  --           diagnostics = {
  --             enable = true,
  --             disabled = { "unresolved-proc-macro" },
  --             enableExperimental = true,
  --           },
  --         },
  --       },
  --     },
  --   },
  --
  --   -- function()
  --   -- Rust dioxus workaround
  --   -- local rust_group = vim.api.nvim_create_augroup("rust_group", {})
  --   -- vim.api.nvim_create_autocmd({ "FileType" }, {
  --   --   pattern = "rust",
  --   --   callback = function()
  --   --     vim.opt_local.backupcopy = "yes"
  --   --   end,
  --   --   group = rust_group,
  --   -- })
  --
  --   -- vim.o.makeprg = "cargo build %"
  --   -- vim.keymap.set({ "n", "i" }, "<C-S>", "<cmd>wa | make!<cr>", { desc = "Save and make the file" })
  --   -- end,
  -- },
}

-- return {
--   {
--     "mrcjkb/rustaceanvim",
--     event = "VeryLazy",
--     version = "^3", -- Recommended
--     ft = { "rust" },
--     config = function()
--       vim.g.rustaceanvim = {
--         server = {
--           settings = {
--             ["rust-analyzer"] = {
--               cargo = { allFeatures = true },
--               checkOnSave = true,
--               check = {
--                 enable = true,
--                 command = "clippy",
--                 features = "all",
--               },
--               procMacro = {
--                 enable = true,
--               },
--             },
--           },
--         },
--       }
--     end,
--   },
--
--   {
--     "hrsh7th/nvim-cmp",
--     dependencies = {
--       {
--         "Saecki/crates.nvim",
--         event = { "BufRead Cargo.toml" },
--         opts = {
--           src = {
--             cmp = { enabled = true },
--           },
--         },
--       },
--     },
--     ---@param opts cmp.ConfigSchema
--     opts = function(_, opts)
--       local cmp = require("cmp")
--       opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
--         { name = "crates" },
--       }))
--     end,
--   },
--
--   {
--     "Saecki/crates.nvim",
--     event = { "BufRead Cargo.toml" },
--     opts = {
--       src = {
--         cmp = { enabled = true },
--       },
--     },
--   },
--
--   {
--     "rouge8/neotest-rust",
--   },
--
--   {
--     "nvim-neotest/neotest",
--     optional = true,
--     dependencies = {
--       "rouge8/neotest-rust",
--     },
--     opts = {
--       adapters = {
--         ["neotest-rust"] = {},
--       },
--     },
--   },
-- }
