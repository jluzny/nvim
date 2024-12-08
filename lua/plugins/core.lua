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
  { import = "lazyvim.plugins.extras.editor.mini-diff" },

  -- blink support
  { import = "lazyvim.plugins.extras.coding.blink" },
  -- {
  --   "saghen/blink.cmp",
  --   optional = true,
  --   opts = {
  --     windows = { ghost_text = { enabled = true } },
  --   },
  --   dependencies = {
  --     {
  --       "supermaven-nvim",
  --       opts = {
  --         disable_inline_completion = false,
  --       },
  --     },
  --   },
  -- },

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
      spec = {
        { "<leader>r", group = "+run" },
      },
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        custom_highlights = function(colors)
          return {
            WinSeparator = { fg = colors.sky },
          }
        end,
        color_overrides = {
          mocha = {
            base = "#1d1d1d",
            mantle = "#151515",
            crust = "#101010",
          },
        },
      })
    end,
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

  {
    "folke/snacks.nvim",
    opts = {
      notifier = {
        top_down = false,
        render = "minimal",
      },
    },
  },

  -- {
  --   "rcarriga/nvim-notify",
  --   opts = {
  --     top_down = false,
  --     render = "minimal",
  --   },
  -- },

  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.presets = {
        command_palette = {
          views = {
            cmdline_popup = {
              position = {
                row = "50%",
                col = "50%",
              },
              size = {
                min_width = 60,
                width = "auto",
                height = "auto",
              },
            },
            popupmenu = {
              relative = "editor",
              position = {
                row = 23,
                col = "50%",
              },
              size = {
                width = 60,
                height = "auto",
                max_height = 15,
              },
              border = {
                style = "rounded",
                padding = { 0, 1 },
              },
              win_options = {
                winhighlight = { Normal = "Normal", FloatBorder = "NoiceCmdlinePopupBorder" },
              },
            },
          },
        },
      }
      opts.lsp.signature = {
        opts = { size = { max_height = 15 } },
      }
    end,
  },

  {
    "koenverburg/peepsight.nvim",
    event = "VeryLazy",
    config = function()
      local peepsight = require("peepsight")
      peepsight.setup({
        -- Zig
        -- "Decl",
        -- Rust
        "function_item",
        "struct_item",
        "enum_item",
        "impl_item",
        "trait_item",
        "mod_item",
        "const_item",
        "static_item",
        -- Elixir
        "do_block",
      })
      peepsight.enable()
    end,
  },

  {
    "nvim-treesitter/playground",
    enabled = true,
    event = "VeryLazy",
    config = function()
      vim.keymap.set("n", "<leader>tp", function()
        require("nvim-treesitter-playground.hl-info").show_hl_captures()
      end)
    end,
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
            -- win = { size = 0.10, relative = "win", position = "top" },
            win = {
              type = "float",
              border = "rounded",
              relative = "editor",
              position = { 100, 0 },
              size = { width = 1, height = 0.38 },
            },
            auto_open = false,
            auto_close = true,
            auto_preview = true,
            auto_jump = true,
            focus = true,
            pinned = false,
            multiline = true,
            indent_lines = true,
            padding = false,
            group = true,
            warn_no_results = false,
            open_no_results = false,
            preview = { scratch = false },
            -- filter = {
            --   any = {
            --     buf = 0, -- current buffer
            --     {
            --       severity = vim.diagnostic.severity.ERROR, -- error only
            --       -- limit to files in the current project
            --       function(item)
            --         return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
            --       end,
            --     },
            --   },
            -- },
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
      vim.keymap.set("n", "<F5>", function()
        vim.cmd("wa")
        require("neotest").run.run_last()
      end)
      vim.keymap.set("n", "<F4>", require("neotest").watch.watch)
      -- vim.keymap.set("n", "<F5>", function() vim.cmd("wa") require("neotest").run.run(vim.uv.cwd()) end)
      -- vim.keymap.set("n", "<F9>", require("dap").toggle_breakpoint)
      vim.keymap.set("n", "<F7>", require("persistent-breakpoints.api").toggle_breakpoint)
      vim.keymap.set("n", "<F8>", function()
        if dap.session() then
          dap.continue()
        else
          dapui.open()
          dap.run_last()
        end
      end)
      vim.keymap.set("n", "<F9>", dap.step_over)
      vim.keymap.set("n", "<F10>", dap.step_into)
      vim.keymap.set("n", "<F11>", dap.step_out)
      vim.keymap.set("n", "<F12>", function()
        dapui.toggle()
        local function checkDapSession()
          if dap.session() then
            dap.terminate()
            vim.defer_fn(checkDapSession, 500)
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
              -- { id = "console", size = 0.5, },
              { id = "repl", size = 0.65, },
              { id = "scopes", size = 0.45, },
            },
            position = "bottom", size = 19,
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
}
