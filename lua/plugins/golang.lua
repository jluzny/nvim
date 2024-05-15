if true or vim.g.vscode then
  return {}
end

return {
  { import = "lazyvim.plugins.extras.lang.go" },

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
    },
    event = "VeryLazy", -- { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    config = function()
      require("go").setup({
        -- dap_debug = true,
        trouble = true,
        test_runner = "ginkgo",
        run_in_floaterm = true,
        floaterm = { -- position
          posititon = "bottom", -- one of {`top`, `bottom`, `left`, `right`, `center`, `auto`}
          -- width = 0.45, -- width of float window if not auto
          height = 0.25, -- height of float window if not auto
        },
      })
      -- setup keymaps
      -- vim.keymap.set("n", "<F8>", "<cmd>:write<cr><cmd>:GoRun<cr>i") -- <cmd>:wincmd k<cr>")
    end,
  },
}
