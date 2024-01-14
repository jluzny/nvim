if vim.g.vscode then
  return {}
end

return {
  {
    "akinsho/toggleterm.nvim",
    Event = "VeryLazy",
    config = function()
      require("toggleterm").setup()
    end,
    keys = {
      { [[<C-\>]] },
      {
        "<leader>td",
        "<cmd>ToggleTerm size=40 dir=~/Desktop direction=horizontal<cr>",
        desc = "Open a horizontal terminal at the Desktop directory",
      },
    },
  },

  {
    "NTBBloodbath/zig-tools.nvim",
    Event = "VeryLazy",
    ft = "zig",
    dependencies = {
      {
        "akinsho/toggleterm.nvim",
      },
    },
    config = function(_, opts)
      vim.keymap.set({ "n", "i" }, "<C-S>", "<cmd>wa | make!<cr>", { desc = "Save and make the file" })

      -- local zig_tools_opts = {
      --   expose_commands = true,
      --   --- Check for compilation-time errors
      --   ---@type table
      --   checker = {
      --     --- Enable checker, create commands
      --     ---@type boolean
      --     enable = true,
      --     --- Run before trying to compile?
      --     ---@type boolean
      --     before_compilation = true,
      --     --- Events to run checker
      --     ---@type table
      --     events = {},
      --   },
      --   --- Project compilation helpers
      --   ---@type table
      --   project = {
      --     --- Extract all build tasks from `build.zig` and expose them
      --     ---@type boolean
      --     build_tasks = true,
      --     --- Enable rebuild project on save? (`:ZigLive` command)
      --     ---@type boolean
      --     live_reload = true,
      --     --- Extra flags to be passed to compiler
      --     ---@type table
      --     flags = {
      --       --- `zig build` flags
      --       ---@type table
      --       build = { "BLABLA", "sss:" },
      --       --- `zig run` flags
      --       ---@type table
      --       run = {},
      --     },
      --     --- Automatically compile your project from within Neovim
      --     auto_compile = {
      --       --- Enable automatic compilation
      --       ---@type boolean
      --       enable = false,
      --       --- Automatically run project after compiling it
      --       ---@type boolean
      --       run = true,
      --     },
      --   },
      --   --- zig-tools.nvim integrations
      --   ---@type table
      --   integrations = {
      --     --- Third-party Zig packages manager integration
      --     ---@type table
      --     package_managers = { "zigmod", "gyro" },
      --     --- Zig Language Server
      --     ---@type table
      --     zls = {
      --       --- Enable inlay hints
      --       ---@type boolean
      --       hints = false,
      --       --- Manage installation
      --       ---@type table
      --       management = {
      --         --- Enable ZLS management
      --         ---@type boolean
      --         enable = false,
      --         --- Installation path
      --         ---@type string
      --         install_path = os.getenv("HOME") .. "/.local/bin",
      --         --- Source path (where to clone repository when building from source)
      --         ---@type string
      --         source_path = os.getenv("HOME") .. "/.local/zig/zls",
      --       },
      --     },
      --   },
      -- }
      require("zig-tools").setup()
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "zig" })
      end
    end,
  },

  -- {
  --   "williamboman/mason.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     if type(opts.ensure_installed) == "table" then
  --       vim.list_extend(opts.ensure_installed, { "zls", "codelldb" })
  --     end
  --   end,
  -- },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        zls = {
          setup = {
            zls = function(_, opts)
              local zig_tools_opts = require("lazyvim.util").opts("zig-tools.nvim")
              require("zig-tools").setup(vim.tbl_deep_extend("force", zig_tools_opts or {}, { server = opts }))
              return true
            end,
          },
        },
      },
    },
  },

  -- {
  --   "nvim-neotest/neotest",
  --   optional = true,
  --   dependencies = {
  --     "lawrence-laz/neotest-zig",
  --   },
  --   opts = {
  --     adapters = {
  --       ["neotest-zig"] = {},
  --     },
  --   },
  -- },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      dap.configurations.zig = {
        {
          name = "Zig Run",
          type = "codelldb",
          request = "launch",
          program = function()
            os.execute("zig build")
            local command = "find ! -type d -path './zig-out/bin/*' | grep -v 'Test' | sed 's#.*/##'"
            local bin_location = io.popen(command, "r")
            if bin_location ~= nil then
              return "zig-out/bin/" .. bin_location:read("*a"):gsub("[\n\r]", "")
            else
              return ""
            end
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          -- args = function()
          --   local argv = {}
          --   arg = vim.fn.input(string.format("Arguments: "))
          --   for a in string.gmatch(arg, "%S+") do
          --     table.insert(argv, a)
          --   end
          --   return argv
          -- end,
        },
      }
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.formatting.zigfmt,
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        zig = { "zigfmt" },
      },
    },
  },
}
