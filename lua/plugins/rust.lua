if true or vim.g.vscode then
  return {}
end

return {
  {
    "mrcjkb/rustaceanvim",
    version = "^3", -- Recommended
    ft = { "rust" },
  },

  -- { import = "lazyvim.plugins.extras.lang.rust" },
  --
  -- {
  --   "simrat39/rust-tools.nvim",
  --   event = "VeryLazy",
  --   ft = { "rust" },
  --   keys = function()
  --     return {
  --       { "<F6>", "<cmd>RustLastDebug<cr>", desc = "Rust Last Debug" },
  --       { "<F7>", "<cmd>RustLastRun<cr>", desc = "Rust Last Run" },
  --     }
  --     -- vim.keymap.set("n", "<f6>", require("rust-tools").cached_commands.execute_last_debuggable)
  --     -- vim.keymap.set("n", "<F7>", require("rust-tools").cached_commands.execute_last_runnable)
  --   end,
  -- },
  -- {
  --   "simrat39/rust-tools.nvim",
  --   event = "VeryLazy",
  --   commit = "8b32537618d80b966ffbf1f4ec4d8bd6fa36338a",
  --
  --   opts = function()
  --     local ok, mason_registry = pcall(require, "mason-registry")
  --     local adapter ---@type any
  --     if ok then
  --       -- rust tools configuration for debugging support
  --       local codelldb = mason_registry.get_package("codelldb")
  --       local extension_path = codelldb:get_install_path() .. "/extension/"
  --       local codelldb_path = extension_path .. "adapter/codelldb"
  --       local liblldb_path = ""
  --       if vim.loop.os_uname().sysname:find("Windows") then
  --         liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
  --       elseif vim.fn.has("mac") == 1 then
  --         liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
  --       else
  --         liblldb_path = extension_path .. "lldb/lib/liblldb.so"
  --       end
  --       adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
  --     end
  --     return {
  --       dap = {
  --         adapter = adapter,
  --       },
  --       tools = {
  --         on_initialized = function()
  --           vim.cmd([[
  --             augroup RustLSP
  --               autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
  --               autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
  --               autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
  --             augroup END
  --           ]])
  --           vim.keymap.set("n", "<f6>", require("rust-tools").cached_commands.execute_last_debuggable)
  --           vim.keymap.set("n", "<F7>", require("rust-tools").cached_commands.execute_last_runnable)
  --         end,
  --       },
  --       hover_actions = {
  --         auto_focus = true,
  --       },
  --     }
  --   end,
  -- },
}
