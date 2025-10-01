if vim.g.vscode then
  return {}
end

return {
  -- { import = "lazyvim.plugins.extras.lang.typescript" },
  -- { import = "lazyvim.plugins.extras.linting.eslint" },

  -- {
  --   "dmmulroy/tsc.nvim",
  --   ft = { "typescript", "tsx" },
  --   config = function(_, opts)
  --     opts = {
  --       auto_open_qflist = false,
  --       -- auto_close_qflist = false,
  --       -- auto_focus_qflist = false,
  --       -- auto_start_watch_mode = false,
  --       -- use_trouble_qflist = false,
  --       use_diagnostics = true,
  --       -- run_as_monorepo = false,
  --       -- bin_path = utils.find_tsc_bin(),
  --       enable_progress_notifications = false,
  --       flags = {
  --         -- noEmit = false,
  --         project = function()
  --           return utils.find_nearest_tsconfig()
  --         end,
  --         --   watch = false,
  --       },
  --       -- hide_progress_notifications_from_history = true,
  --       -- spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
  --       -- pretty_errors = true,
  --     }
  --     require("tsc").setup(opts)
  --
  --     vim.keymap.set({ "n" }, "<C-S>", "<cmd>wa | TSC<cr>", { desc = "Execute full TS check after save" })
  --   end,
  -- },
  --

  {
    "nvim-neotest/neotest",
    dependencies = {
      "MatrosMartz/neotest-deno",
    },
    opts = {
      adapters = {
        ["neotest-deno"] = {},
      },
    },
  },

  -- {
  --   "typed-rocks/ts-worksheet-neovim",
  --   opts = {
  --     severity = vim.diagnostic.severity.WARN,
  --   },
  --   config = function(_, opts)
  --     require("tsw").setup(opts)
  --   end,
  -- },

  {
    "mfussenegger/nvim-dap",
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
}
