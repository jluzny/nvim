if vim.g.vscode then
  return {}
end

return {
  { import = "lazyvim.plugins.extras.lang.typescript" },

  {
    "dmmulroy/tsc.nvim",
    ft = { "typescript", "tsx" },
    config = function(_, opts)
      opts = {
        auto_open_qflist = false,
        -- auto_close_qflist = false,
        -- auto_focus_qflist = false,
        -- auto_start_watch_mode = false,
        -- use_trouble_qflist = false,
        use_diagnostics = true,
        -- run_as_monorepo = false,
        -- bin_path = utils.find_tsc_bin(),
        -- enable_progress_notifications = true,
        flags = {
          -- noEmit = true,
          --   project = function()
          --     return utils.find_nearest_tsconfig()
          --   end,
          --   watch = false,
        },
        -- hide_progress_notifications_from_history = true,
        -- spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
        -- pretty_errors = true,
      }
      require("tsc").setup(opts)

      vim.keymap.set({ "n" }, "<C-S>", "<cmd>wa | TSC<cr>", { desc = "Execute full TS check after save" })
    end,
  },

  {
    "mfussenegger/nvim-dap",
    opts = function(_, opts)
      local dap = require("dap")
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "bun",
          args = {
            require("mason-registry").get_package("js-debug-adapter"):get_install_path()
              .. "/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      for _, language in ipairs({ "typescript", "javascript" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Tsx",
            cwd = vim.fn.getcwd(),
            -- runtimeArgs = { "--no-warnings=ExperimentalWarning", "--loader", "ts-node/esm" },
            runtimeExecutable = "tsx",
            args = { "${file}", "hello" },
            sourceMaps = true,
            protocol = "inspector",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
          },
          -- {
          --   type = "pwa-node",
          --   request = "launch",
          --   name = "Launch Bun",
          --   cwd = vim.fn.getcwd(),
          --   runtimeArgs = { "--inspect-wait" },
          --   program = "${file}",
          --   -- sourceMaps = true,
          --   protocol = "inspector",
          --   runtimeExecutable = "bun",
          --   attachSimplePort = 6499,
          -- },
          -- {
          --   type = "pwa-node",
          --   request = "launch",
          --   name = "Launch Deno",
          --   cwd = vim.fn.getcwd(),
          --   runtimeArgs = { "run", "--inspect-wait" },
          --   program = "${file}",
          --   -- sourceMaps = true,
          --   -- protocol = "inspector",
          --   runtimeExecutable = "deno",
          --   attachSimplePort = 9229,
          -- },
        }
      end
    end,
  },

  -- add typescript to treesitter
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = function(_, opts)
  --     if type(opts.ensure_installed) == "table" then
  --       vim.list_extend(opts.ensure_installed, { "typescript", "tsx", "javascript" })
  --     end
  --   end,
  -- },

  -- correctly setup lspconfig
  -- {
  --   "neovim/nvim-lspconfig",
  --   dependencies = { "jose-elias-alvarez/typescript.nvim" },
  --   opts = {
  --     -- make sure mason installs the server
  --     servers = {
  --       ---@type lspconfig.options.tsserver
  --       tsserver = {
  --         keys = {
  --           { "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
  --           { "<leader>cR", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
  --         },
  --         settings = {
  --           typescript = {
  --             format = {
  --               indentSize = vim.o.shiftwidth,
  --               convertTabsToSpaces = vim.o.expandtab,
  --               tabSize = vim.o.tabstop,
  --             },
  --           },
  --           javascript = {
  --             format = {
  --               indentSize = vim.o.shiftwidth,
  --               convertTabsToSpaces = vim.o.expandtab,
  --               tabSize = vim.o.tabstop,
  --             },
  --           },
  --           completions = {
  --             completeFunctionCalls = true,
  --           },
  --         },
  --       },
  --     },
  --     setup = {
  --       tsserver = function(_, opts)
  --         require("typescript").setup({ server = opts })
  --         return true
  --       end,
  --     },
  --   },
  -- },

  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     table.insert(opts.sources, require("typescript.extensions.null-ls.code-actions"))
  --   end,
  -- },

  -- {
  --   "mfussenegger/nvim-dap",
  --   dependencies = {
  --     {
  --       "williamboman/mason.nvim",
  --       opts = function(_, opts)
  --         opts.ensure_installed = opts.ensure_installed or {}
  --         table.insert(opts.ensure_installed, "js-debug-adapter")
  --       end,
  --     },
  --   },
  --   opts = function()
  --     local dap = require("dap")
  --     if not dap.adapters["pwa-node"] then
  --       require("dap").adapters["pwa-node"] = {
  --         type = "server",
  --         host = "localhost",
  --         port = "${port}",
  --         executable = {
  --           command = "node",
  --           args = {
  --             require("mason-registry").get_package("js-debug-adapter"):get_install_path()
  --               .. "/js-debug/src/dapDebugServer.js",
  --             "${port}",
  --           },
  --         },
  --       }
  --     end
  --     for _, language in ipairs({ "typescript", "javascript" }) do
  --       if not dap.configurations[language] then
  --         dap.configurations[language] = {
  --           {
  --             type = "pwa-node",
  --             request = "launch",
  --             name = "Launch Current File (pwa-node with ts-node)",
  --             cwd = vim.fn.getcwd(),
  --             -- runtimeArgs = { "--no-warnings=ExperimentalWarning", "--loader", "ts-node/esm" },
  --             runtimeExecutable = "tsx",
  --             args = { "${file}" },
  --             sourceMaps = true,
  --             protocol = "inspector",
  --             skipFiles = { "<node_internals>/**", "node_modules/**" },
  --             resolveSourceMapLocations = {
  --               "${workspaceFolder}/**",
  --               "!**/node_modules/**",
  --             },
  --           },
  --           -- {
  --           --   name = "Launch Node Program",
  --           --   type = "pwa-node",
  --           --   request = "launch",
  --           --   program = "${file}",
  --           --   rootPath = "${workspaceFolder}",
  --           --   cwd = "${workspaceFolder}",
  --           --   sourceMaps = true,
  --           --   resolveSourceMapLocations = { "${workspaceFolder}/buid/**/*.js", "!**/node_modules/**" },
  --           --   skipFiles = { "<node_internals>/**", "node_modules/**" },
  --           --   protocol = "inspector",
  --           --   console = "integratedTerminal",
  --           -- },
  --           -- {
  --           --   type = "pwa-node",
  --           --   request = "attach",
  --           --   name = "Attach",
  --           --   processId = require("dap.utils").pick_process,
  --           --   cwd = "${workspaceFolder}",
  --           -- },
  --         }
  --       end
  --     end
  --   end,
  -- },
}
