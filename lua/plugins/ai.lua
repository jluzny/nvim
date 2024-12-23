if false or vim.g.vscode then
  return {}
end

return {
  -- Copilot
  { import = "lazyvim.plugins.extras.ai.supermaven" },
  -- { import = "lazyvim.plugins.extras.ai.copilot" },
  { import = "lazyvim.plugins.extras.ai.copilot-chat" },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    cmd = "CopilotChat",
    opts = { model = "claude-3.5-sonnet" },
  },

  -- Minuet
  -- {
  --   "milanglacier/minuet-ai.nvim",
  --   config = function()
  --     require("minuet").setup({
  --       provider = "claude",
  --       provider_options = {
  --         model = "claude-3-5-sonnet-20241022",
  --       },
  --     })
  --   end,
  -- },
  -- { "nvim-lua/plenary.nvim" },
  -- {
  --   "nvim-cmp",
  --   opts = function(_, opts)
  --     -- if you wish to use autocomplete
  --     -- table.insert(opts.sources, 1, {
  --     --   name = "minuet",
  --     --   group_index = 1,
  --     --   priority = 100,
  --     -- })
  --
  --     opts.performance = {
  --       -- It is recommended to increase the timeout duration due to
  --       -- the typically slower response speed of LLMs compared to
  --       -- other completion sources. This is not needed when you only
  --       -- need manual completion.
  --       -- fetching_timeout = 2000,
  --     }
  --
  --     opts.mapping = vim.tbl_deep_extend("force", opts.mapping or {}, {
  --       -- if you wish to use manual complete
  --       ["<S-Space>"] = require("minuet").make_cmp_map(),
  --       -- You don't need to worry about <CR> delay because lazyvim handles this situation for you.
  --       ["<CR>"] = nil,
  --     })
  --   end,
  -- },

  -- {
  --   "olimorris/codecompanion.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }, -- Optional: For prettier markdown rendering
  --     { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
  --   },
  --   config = function(_, opts)
  --     require("codecompanion").setup({
  --       strategies = {
  --         chat = {
  --           adapter = "anthropic",
  --         },
  --         inline = {
  --           adapter = "anthropic",
  --         },
  --         agent = {
  --           adapter = "anthropic",
  --         },
  --       },
  --       display = {
  --         chat = {
  --           window = {
  --             layout = "vertical", -- float|vertical|horizontal|buffer
  --             width = 0.35,
  --             relative = "editor",
  --           },
  --         },
  --         diff = {
  --           provider = "mini_diff",
  --         },
  --       },
  --     })
  --   end,
  -- },

  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   lazy = false,
  --   version = false, -- set this if you want to always pull the latest change
  --   opts = {
  --     -- add any opts here
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "echasnovski/mini.icons",
  --     -- "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },

  -- {
  --   "joshuavial/aider.nvim",
  --   config = function()
  --     require("aider").setup({
  --       auto_manage_context = true,
  --       default_bindings = true,
  --     })
  --   end,
  --   keys = {
  --     {
  --       "oa",
  --       function()
  --         require("aider").AiderOpen()
  --       end,
  --       desc = "Aider Open",
  --     },
  --     {
  --       "ob",
  --       function()
  --         require("aider").AiderBackground()
  --       end,
  --       desc = "Aider Background",
  --     },
  --   },
  -- },

  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = function(_, opts)
  --     local cmp = require("cmp")
  --     opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
  --       {
  --         name = "supermaven",
  --         group_index = 1,
  --         priority = 100,
  --       },
  --     }))
  --   end,
  -- },
}
