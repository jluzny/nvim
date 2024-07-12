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

  -- {
  --   "folke/tokyonight.nvim",
  --   name = "tokyonight",
  --   priority = 1000,
  --   opts = {
  --     colorscheme = "night",
  --   },
  -- },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },

  { "echasnovski/mini.pairs", enabled = false },
  { "echasnovski/mini.animate", enabled = false },

  {
    "koenverburg/peepsight.nvim",
    event = "VeryLazy",
    config = function()
      local peepsight = require("peepsight")
      peepsight.setup({
        -- Zig
        "Decl",
      })
      peepsight.enable()
    end,
  },

  -- {
  --   "nvim-treesitter/playground",
  --   enabled = true,
  --   event = "VeryLazy",
  --   config = function()
  --     vim.keymap.set("n", "<leader>tp", function()
  --       require("nvim-treesitter-playground.hl-info").show_hl_captures()
  --     end)
  --   end,
  -- },

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

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "build" },
            },
          },
          skip = true,
        },
      },
    },
  },

  {
    "folke/trouble.nvim",
    config = function()
      local opts = {
        modes = {
          diagnostics = {
            win = { size = 0.15, relative = "win" },
            auto_open = true,
            auto_close = true,
            auto_preview = false,
            auto_jump = true,
            pinned = false,
            multiline = false,
            indent_lines = false,
            padding = false,
            group = true,
            warn_no_results = false,
            open_no_results = false,
            preview = { scratch = false },
            filter = {
              any = {
                buf = 0, -- current buffer
                {
                  severity = vim.diagnostic.severity.ERROR, -- error only
                  -- limit to files in the current project
                  function(item)
                    return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
                  end,
                },
              },
            },
          },
        },
      }
      local trouble = require("trouble")
      trouble.setup(opts)
      -- vim.diagnostic.enable(false)

      -- vim.api.nvim_create_autocmd("BufReadPost", {
      --   desc = "Replace diagnostics list with trouble.nvim",
      --   callback = function()
      --     vim.defer_fn(function()
      --       vim.cmd("Trouble diagnostics")
      --     end, 0)
      --   end,
      -- })
    end,

    -- config = function()
    --   -- local opts = {
    --   --   height = 5,
    --   --   auto_open = true,
    --   --   auto_close = false,
    --   --   auto_preview = true,
    --   --   multiline = false,
    --   --   indent_lines = false,
    --   --   padding = false,
    --   --   group = true,
    --   -- }
    --   local trouble = require("trouble")
    --   -- trouble.setup({ defaults = { opts } })
    --
    --   vim.api.nvim_create_autocmd("BufWritePost", {
    --     desc = "Replace quick/local lists with trouble.nvim",
    --     callback = function()
    --       vim.defer_fn(function()
    --         local qflist = vim.fn.getqflist({ title = 0, items = 0 })
    --         if next(qflist.items) == nil then
    --           vim.notify("All right :-)", vim.log.levels.INFO, { title = "Shell Cmd Post" })
    --           if trouble.is_open() then
    --             trouble.open("workspace_diagnostics")
    --             trouble.close()
    --           end
    --         else
    --           vim.cmd.lclose()
    --           vim.notify("There are some issues ...", vim.log.levels.ERROR, { title = "Shell Cmd Post" })
    --           trouble.open("quickfix")
    --           vim.cmd("res 5")
    --         end
    --       end, 0)
    --     end,
    --   })
    --   return true
    -- end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
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
      local dap = require("dap")
      local dapui = require("dapui")

      -- Debug keymapping
      -- stylua: ignore
      vim.keymap.set({"n","v"}, "<F2>", dapui.eval)
      -- vim.keymap.set("n", "<F6>", require("dap").run_last)
      -- vim.keymap.set("n", "<F5>", require("neotest").run.run_last)
      vim.keymap.set("n", "<F4>", require("neotest").watch.watch)
      vim.keymap.set("n", "<F5>", function()
        vim.cmd("wa")
        require("neotest").run.run(vim.uv.cwd())
      end)
      -- vim.keymap.set("n", "<F9>", require("dap").toggle_breakpoint)
      vim.keymap.set("n", "<F7>", require("persistent-breakpoints.api").toggle_breakpoint)
      vim.keymap.set("n", "<F8>", function()
        dapui.open()
        dap.continue()
      end)
      vim.keymap.set("n", "<F9>", dap.step_over)
      vim.keymap.set("n", "<F10>", dap.step_into)
      vim.keymap.set("n", "<F11>", dap.step_out)
      vim.keymap.set("n", "<F12>", function()
        dapui.toggle()
        local function checkDapSession()
          if dap.session() then
            dap.terminate()
            vim.defer_fn(checkDapSession, 1000)
          end
        end

        if dap.session() then
          checkDapSession()
        end
      end)
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
              -- { id = "console", size = 0.6, },
              { id = "repl", size = 0.6, },
              { id = "scopes", size = 0.4, },
            },
            position = "bottom", size = 10,
          },
        },
      }
      dapui.setup(opts)

      -- toggle windows after debug
      dap.listeners.before.event_initialized["dapui_config"] = function()
        dapui.open({ reset = true })
        vim.g.dap_current_buf = vim.api.nvim_get_current_buf()
        -- vim.cmd("Neotree close")
      end

      dap.listeners.after.event_terminated["dapui_config"] = function()
        -- dapui.close()
        vim.api.nvim_set_current_buf(vim.g.dap_current_buf)
        -- vim.defer_fn(function()
        --   local bufs = vim.api.nvim_list_bufs()
        --   for _, i in ipairs(bufs) do
        --     if vim.api.nvim_get_option_value("readonly", { buf = i }) then
        --       vim.api.nvim_buf_delete(i, { "force" })
        --     end
        --   end
        -- end, 100000)
      end

      -- dap.defaults.fallback.external_terminal = {
      --   command = "/usr/bin/alacritty",
      --   args = { "-e" },
      -- }
      -- dap.defaults.fallback.force_external_terminal = true
    end,
  },

  -- {
  --   "hrsh7th/nvim-cmp",
  --   version = false, -- last release is way too old
  --   event = "InsertEnter",
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --   },
  --   opts = function()
  --     vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
  --     local cmp = require("cmp")
  --     local defaults = require("cmp.config.default")()
  --     return {
  --       completion = {
  --         completeopt = "menu,menuone,noinsert,noselect",
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  --         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
  --         ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<C-e>"] = cmp.mapping.abort(),
  --         ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --         ["<C-CR>"] = cmp.mapping.confirm({
  --           behavior = cmp.ConfirmBehavior.Replace,
  --           select = true,
  --         }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  --         ["<S-CR>"] = function(fallback)
  --           cmp.abort()
  --           fallback()
  --         end,
  --       }),
  --       sources = cmp.config.sources({
  --         { name = "nvim_lsp" },
  --         { name = "path" },
  --       }, {
  --         { name = "buffer" },
  --       }),
  --       formatting = {
  --         format = function(_, item)
  --           local icons = require("lazyvim.config").icons.kinds
  --           if icons[item.kind] then
  --             item.kind = icons[item.kind] .. item.kind
  --           end
  --           return item
  --         end,
  --       },
  --       experimental = {
  --         ghost_text = {
  --           hl_group = "CmpGhostText",
  --         },
  --       },
  --       sorting = defaults.sorting,
  --     }
  --   end,
  -- },

  { import = "lazyvim.plugins.extras.coding.copilot" },
  { import = "lazyvim.plugins.extras.coding.copilot-chat" },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   config = function()
  --     require("nvim-cmp").event:on("menu_opened", function()
  --       vim.b.copilot_suggestion_hidden = true
  --     end)
  --
  --     require("nvim-cmp").event:on("menu_closed", function()
  --       vim.b.copilot_suggestion_hidden = false
  --     end)
  --   end,
  -- },

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
