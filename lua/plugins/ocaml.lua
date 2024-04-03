if vim.g.vscode then
  return {}
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ocaml" })
      end
      -- vim.keymap.set({ "n", "i" }, "<C-S>", "<cmd>wa | make<cr>", { desc = "Save and make the file" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ocamllsp = {},
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "ocamlearlybird" })
        end,
      },
    },
    opts = function(_, opts)
      local dap = require("dap")
      if not dap.adapters["ocaml.earlybird"] then
        dap.adapters["ocaml.earlybird"] = {
          type = "executable",
          command = "ocamlearlybird",
          args = { "debug" },
          cwd = "${workspaceRoot}",
        }
        dap.configurations.ocaml = {
          {
            name = "ocaml.earlybird",
            type = "ocaml.earlybird",
            request = "launch",
            stopOnEntry = false,
            program = "/home/jiri/dev/ocaml/learning/hello_world/_build/default/bin/main.bc",
            onlyDebugGlob = "<${workspaceRoot}/**/*>",
            -- yieldSteps = 1024,
          },
        }
      end
    end,
  },
}
