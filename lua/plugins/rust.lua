if vim.g.vscode then
  return {}
end

return {
  -- { import = "lazyvim.plugins.extras.lang.rust" },

  {
    "mrcjkb/rustaceanvim",
    version = "6.2",
    opts = function(_, opts)
      opts = opts or {}
      local local_opts = opts
      local path = { "server", "default_settings", "rust-analyzer", "procMacro", "ignored" }

      for i = 1, #path - 1 do
        local_opts[path[i]] = local_opts[path[i]] or {}
        local_opts = local_opts[path[i]]
      end
      local_opts[path[#path]] = {
        ["napi-derive"] = { "napi" },
        ["async-recursion"] = { "async_recursion" },
      }

      return opts
    end,
  },

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
          name = "Generic Debug Rust (gdb)",
          type = "gdb",
          request = "launch",
          externalConsole = "true",
          preLaunchTask = "cargo build",
          program = function()
            return vim.fn.input(
              "Path to executable: ",
              vim.fn.getcwd() .. "/target/x86_64-unknown-linux-gnu/debug",
              "file"
            )
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
    end,
  },

  {
    "nvim-neotest/neotest",
    optional = true,
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
      },
    },
  },
}
