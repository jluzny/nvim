if vim.g.vscode then
  return {}
end

return {
  { import = "lazyvim.plugins.extras.lang.rust" },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      local dap = require("dap")

      dap.adapters["gdb"] = {
        type = "executable",
        command = "gdb",
        args = {
          "--quiet",
          "--interpreter=dap",
          "--init-eval-command=add-auto-load-safe-path ~/.rustup/toolchains",
          "--init-eval-command=dir ~/.rustup/toolchains/"
            .. vim.fn.getenv("RUST_TOOLCHAIN")
            .. "-x86_64-unknown-linux-gnu/lib/rustlib/etc",
        },
      }

      dap.configurations.rust = {
        {
          name = "Debug Rust",
          type = "gdb",
          request = "launch",
          externalConsole = "true",
          preLaunchTask = "cargo build",
          program = function()
            return vim.fn.input(
              "Path to executable: ",
              vim.fn.getcwd() .. "/target/x86_64-unknown-linux-gnu/debug/hass-hvac-control",
              "file"
            )
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
    end,
  },

  -- recommended = function()
  --   return LazyVim.extras.wants({
  --     ft = "rust",
  --     root = { "Cargo.toml", "rust-project.json" },
  --   })
  -- end,
  --
  -- -- LSP for Cargo.toml
  -- {
  --   "Saecki/crates.nvim",
  --   event = { "BufRead Cargo.toml" },
  --   opts = {
  --     completion = {
  --       crates = {
  --         enabled = true,
  --       },
  --     },
  --     lsp = {
  --       enabled = true,
  --       actions = true,
  --       completion = true,
  --       hover = true,
  --     },
  --   },
  -- },
  --
  -- -- Add Rust & related to treesitter
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = { ensure_installed = { "rust", "ron" } },
  -- },
  --
  -- -- Ensure Rust debugger is installed
  -- {
  --   "williamboman/mason.nvim",
  --   optional = true,
  --   opts = { ensure_installed = { "codelldb" } },
  -- },
  --
  -- {
  --   "mrcjkb/rustaceanvim",
  --   -- version = "^4", -- Recommended
  --   ft = { "rust" },
  --   opts = {
  --     server = {
  --       on_attach = function(_, bufnr)
  --         vim.keymap.set("n", "<leader>cR", function()
  --           vim.cmd.RustLsp("codeAction")
  --         end, { desc = "Code Action", buffer = bufnr })
  --         vim.keymap.set("n", "<leader>dr", function()
  --           vim.cmd.RustLsp("debuggables")
  --         end, { desc = "Rust Debuggables", buffer = bufnr })
  --       end,
  --       default_settings = {
  --         -- rust-analyzer language server configuration
  --         ["rust-analyzer"] = {
  --           cargo = {
  --             allFeatures = true,
  --             loadOutDirsFromCheck = true,
  --             buildScripts = {
  --               enable = true,
  --             },
  --           },
  --           completion = {
  --             postfix = { enable = false },
  --           },
  --           -- Add clippy lints for Rust.
  --           checkOnSave = true,
  --           procMacro = {
  --             enable = true,
  --             ignored = {
  --               -- ["async-trait"] = { "async_trait" },
  --               ["napi-derive"] = { "napi" },
  --               ["async-recursion"] = { "async_recursion" },
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
  --     if vim.fn.executable("rust-analyzer") == 0 then
  --       LazyVim.error(
  --         "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
  --         { title = "rustaceanvim" }
  --       )
  --     end
  --   end,
  -- },
  --
  -- -- Correctly setup lspconfig for Rust 🚀
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       rust_analyzer = { enabled = false },
  --     },
  --   },
  -- },
  --
  -- {
  --   "nvim-neotest/neotest",
  --   optional = true,
  --   opts = {
  --     adapters = {
  --       ["rustaceanvim.neotest"] = {},
  --     },
  --   },
  -- },
}
