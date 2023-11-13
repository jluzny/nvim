if true or vim.g.vscode then
  return {}
end

return {
  -- add treesitter support for scala
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "scala", "java" })
    end,
  },

  -- {
  --   "PiotrBosak/neotest-scala",
  --   init = function()
  --     require("neotest").setup({
  --       adapters = {
  --         require("neotest-scala"),
  --       },
  --     })
  --   end,
  --   opt = {
  --     framework = "scalatest",
  --   },
  -- },

  -- lualine component for metals
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 2, {
        function()
          local status = vim.g["metals_status"]
          if status == nil then
            return ""
          end
          return status
        end,
        color = function()
          return require("lazyvim.util").ui.fg("DiagnosticWarn")
        end,
      })
    end,
  },

  {
    "scalameta/nvim-metals",
    dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap" },
    event = "BufEnter *.worksheet.sc",
    ft = { "scala", "sbt" },
    keys = {
      {
        "<leader>cW",
        function()
          require("metals").hover_worksheet()
        end,
        desc = "Metals Worksheet",
      },
      {
        "<leader>cM",
        function()
          require("telescope").extensions.metals.commands()
        end,
        desc = "Telescope Metals Commands",
      },
    },

    config = function()
      local metals_config = require("metals").bare_config()

      metals_config.settings = {
        showImplicitArguments = true,
        showImplicitConversionsAndClasses = true,
        showInferredType = true,
        superMethodLensesEnabled = true,
        -- testUserInterface = "Test Explorer",
      }
      metals_config.init_options.statusBarProvider = "on"
      metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt" },
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      }) -- Debug settings if you're using nvim-dap
      local dap = require("dap")

      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "RunOrTest",
          metals = {
            runType = "runOrTestFile",
            --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test Target",
          -- console = "integratedTerminal",
          metals = {
            runType = "testTarget",
          },
        },
      }

      metals_config.on_attach = function(client, bufnr)
        local metals = require("metals")
        metals.setup_dap()

        local wk = require("which-key")
        wk.register({
          ["<localleader>"] = {
            h = {
              name = "hover",
              c = {
                function()
                  metals.toggle_setting("showImplicitConversionsAndClasses")
                end,
                "Toggle show implicit conversions and classes",
              },
              i = {
                function()
                  metals.toggle_setting("showImplicitArguments")
                end,
                "Toggle show implicit arguments",
              },
              t = {
                function()
                  metals.toggle_setting("showInferredType")
                end,
                "Toggle show inferred type",
              },
            },
            t = {
              name = "Tree view",
              t = {
                function()
                  require("metals.tvp").toggle_tree_view()
                end,
                "Toggle tree view",
              },
              r = {
                function()
                  require("metals.tvp").reveal_in_tree()
                end,
                "Review in tree view",
              },
            },
            w = {
              function()
                metals.hover_worksheet({ border = "single" })
              end,
              "Hover worksheet",
            },
          },
        }, {
          buffer = bufnr,
        })
        wk.register({
          ["<localleader>t"] = {
            function()
              metals.type_of_range()
            end,
            "Type of range",
          },
        }, {
          mode = "v",
          buffer = bufnr,
        })
      end
    end,
  },
}
