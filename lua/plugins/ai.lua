if false or vim.g.vscode then
  return {}
end

return {
  -- Copilot
  -- { import = "lazyvim.plugins.extras.coding.copilot" },
  -- { import = "lazyvim.plugins.extras.coding.copilot-chat" },

  -- Minuet
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require("minuet").setup({
        provider = "claude",
      })
    end,
  },
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-cmp",
    opts = function(_, opts)
      -- if you wish to use autocomplete
      table.insert(opts.sources, 1, {
        name = "minuet",
        group_index = 1,
        priority = 100,
      })

      opts.performance = {
        -- It is recommended to increase the timeout duration due to
        -- the typically slower response speed of LLMs compared to
        -- other completion sources. This is not needed when you only
        -- need manual completion.
        -- fetching_timeout = 2000,
      }

      opts.mapping = vim.tbl_deep_extend("force", opts.mapping or {}, {
        -- if you wish to use manual complete
        ["<C-S-Space>"] = require("minuet").make_cmp_map(),
        -- You don't need to worry about <CR> delay because lazyvim handles this situation for you.
        ["<CR>"] = nil,
      })
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- Optional
      {
        "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
        opts = {},
      },
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "anthropic",
          },
          inline = {
            adapter = "anthropic",
          },
          agent = {
            adapter = "anthropic",
          },
        },
      })
    end,
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    opts = {
      -- add any opts here
    },
    keys = {
      {
        "<leader>aa",
        function()
          require("avante.api").ask()
        end,
        desc = "avante: ask",
        mode = { "n", "v" },
      },
      {
        "<leader>ar",
        function()
          require("avante.api").refresh()
        end,
        desc = "avante: refresh",
      },
      {
        "<leader>ae",
        function()
          require("avante.api").edit()
        end,
        desc = "avante: edit",
        mode = "v",
      },
    },
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.icons",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to setup it properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  {
    "joshuavial/aider.nvim",
    config = function()
      require("aider").setup({
        auto_manage_context = true,
        default_bindings = true,
      })
    end,
    keys = {
      {
        "oa",
        function()
          require("aider").AiderOpen()
        end,
        desc = "Aider Open",
      },
      {
        "ob",
        function()
          require("aider").AiderBackground()
        end,
        desc = "Aider Background",
      },
    },
  },
}
