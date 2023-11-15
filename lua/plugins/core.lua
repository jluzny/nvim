if vim.g.vscode then
  return {
    { import = "lazyvim.plugins.extras.vscode" },
  }
end

return {
  -- eneble plugins and extras
  { import = "lazyvim.plugins.extras.lsp.none-ls" },
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.util.project" },
  { import = "lazyvim.plugins.extras.ui.mini-animate" },
  { import = "lazyvim.plugins.extras.test.core" },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>r"] = { name = "+run" },
      },
    },
  },

  -- {
  --   "folke/twilight.nvim",
  --   event = "VeryLazy",
  --   config = function(_, opts)
  --     opts = {
  --       dimming = {
  --         alpha = 1, -- amount of dimming
  --       },
  --       context = 66,
  --       treesitter = true, -- use treesitter when available for the filetype
  --       expand = {
  --         "while_statement",
  --         "if_statement",
  --         "for_statement",
  --         "function",
  --         "function_definition",
  --         "method_definition",
  --         "method",
  --         "table",
  --         "if_statement",
  --         "paragraph",
  --         "fenced_code_block",
  --         "list",
  --         "document",
  --       },
  --       exclude = {}, -- exclude these filetypes
  --     }
  --     require("twilight").setup(opts)
  --     vim.cmd("TwilightEnable")
  --   end,
  -- },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      color_overrides = {
        mocha = {
          base = "#1d1d1d",
          mantle = "#151515",
          crust = "#101010",
        },
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ reveal = true, dir = require("lazyvim.util").root.get() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ reveal = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = true,
          hide_gitignored = true,
        },
      },
      window = {
        position = "float",
      },
    },
  },

  -- debug support
  {
    "Weissle/persistent-breakpoints.nvim",
    event = "VeryLazy",
    config = function()
      require("persistent-breakpoints").setup({
        load_breakpoints_event = { "BufReadPost" },
      })

      -- Debug keymapping
      -- stylua: ignore
      vim.keymap.set("n", "<F4>", require("dap").terminate)
      vim.keymap.set("n", "<F5>", require("dap").continue)
      vim.keymap.set("n", "<F6>", require("dap").run_last)
      -- vim.keymap.set("n", "<F7>", require("neotest").run.run_last)
      vim.keymap.set("n", "<F8>", require("neotest").watch.watch)
      -- vim.keymap.set("n", "<F8>", require("neotest").run.run)
      -- vim.keymap.set("n", "<F9>", require("dap").toggle_breakpoint)
      vim.keymap.set("n", "<F9>", require("persistent-breakpoints.api").toggle_breakpoint)
      vim.keymap.set("n", "<F10>", require("dap").step_over)
      vim.keymap.set("n", "<F11>", require("dap").step_into)
      vim.keymap.set("n", "<F12>", require("dap").step_out)
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      -- stylua: ignore
      opts = {
        layouts = {
          -- {
          --   elements = {
          --     { id = "scopes", size = 0.7, },
          --   --   -- { id = "breakpoints", size = 0.25, },
          --   --   -- { id = "stacks", size = 0.25, },
          --   --   { id = "watches", size = 0.1, },
          --     { id = "repl", size = 0.3, },
          --   },
          --   position = "right", size = 33,
          -- },
          {
            elements = {
              -- { id = "console", size = 1, },
              { id = "repl", size = 0.5, },
              { id = "scopes", size = 0.5, },
            },
            position = "bottom", size = 17,
          },
        },
      }
      dapui.setup(opts)

      -- toggle windows after debug
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
        -- vim.cmd("Neotree close")
      end

      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
        -- vim.cmd("Neotree show")
      end

      -- dap.defaults.fallback.external_terminal = {
      --   command = "/usr/bin/alacritty",
      --   args = { "-e" },
      -- }
      -- dap.defaults.fallback.force_external_terminal = true
    end,
  },

  -- AI

  { import = "lazyvim.plugins.extras.coding.copilot" },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = { enabled = true },
      panel = { enabled = true },
    },
  },

  -- {
  --   "Djancyp/cheat-sheet",
  --   event = "VeryLazy",
  -- },

  -- {
  --   "jackMort/ChatGPT.nvim",
  --   -- event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup({})
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --   },
  -- },

  -- {
  --   "Exafunction/codeium.vim",
  --   event = "InsertEnter",
  --   -- stylua: ignore
  --   config = function ()
  --     vim.g.codeium_disable_bindings = 1
  --     vim.keymap.set("i", "<A-m>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
  --     vim.keymap.set("i", "<A-f>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
  --     vim.keymap.set("i", "<A-b>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
  --     vim.keymap.set("i", "<A-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
  --     vim.keymap.set("i", "<A-s>", function() return vim.fn["codeium#Complete"]() end, { expr = true })
  --   end,
  -- },
  --
  --
  -- {
  --   "jcdickinson/codeium.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     require("codeium").setup({})
  --   end,
  -- },
}
