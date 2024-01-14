-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

if not vim.g.vscode then
  vim.api.nvim_create_autocmd("ShellCmdPost", {
    desc = "Replace quick/local lists with trouble.nvim",
    callback = function()
      vim.defer_fn(function()
        local qflist = vim.fn.getqflist({ title = 0, items = 0 })
        local trouble = require("trouble")
        if next(qflist.items) == nil then
          local loclist = vim.fn.getloclist(0)
          -- if loclist == nil and loclist.items == nil then
          -- if trouble.is_open() then
          -- trouble.toggle("workspace_diagnostics")
          vim.notify("All right :-)", vim.log.levels.INFO, { title = "Shell Cmd Post" })
          trouble.open("workspace_diagnostics")
          vim.cmd("wincmd p")
          -- trouble.action("preview")
          -- trouble.close()
          -- end
          -- else
          -- trouble.
          -- end
          -- vim.defer_fn(function()
          --   trouble.toggle("quickfix")
          -- end, 0)
        else
          vim.cmd.lclose()
          vim.notify("There are some issues ...", vim.log.levels.ERROR, { title = "Shell Cmd Post" })
          trouble.open("quickfix")
        end
        -- vim.defer_fn(function()
        --   vim.cmd.lclose()
        --   trouble.open("loclist")
        -- end, 0)
        -- vim.defer_fn(function()
        --   vim.cmd.cclose()
        --   trouble.open("quickfix")
      end, 0)
    end,
  })

  -- vim.api.nvim_create_autocmd("BufNew", {
  --   desc = "VS Code: auto select virtualenv Nvim open, and VS Code launch.json config activation",
  --   pattern = "*.py",
  --   callback = function()
  --     local pyproject = vim.fn.findfile("pyproject.toml", ".;")
  --     if pyproject ~= "" then
  --       require("venv-selector").retrieve_from_cache()
  --       require("dap.ext.vscode").load_launchjs()
  --     end
  --   end,
  --   once = true,
  -- })

  -- vim.api.nvim_create_autocmd("BufReadPre", {
  --   desc = "Open neo-tree on enter",
  --   callback = function()
  --     if not vim.g.neotree_opened then
  --       vim.cmd("Neotree float")
  --       vim.g.neotree_opened = true
  --     end
  --   end,
  -- })

  -- vim.api.nvim_create_autocmd("BufNew", {
  --   desc = "Open DAP UI on enter",
  --   pattern = "*.py,*.ts,*.js",
  --   callback = function()
  --     if not vim.g.dapui_opened then
  --       require("dapui").open({})
  --       vim.g.dapui_opened = true
  --     end
  --   end,
  -- })

  -- vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  --   group = vim.api.nvim_create_augroup("SemanticHighlight", {}),
  --   callback = function()
  --     -- Only add style, inherit or link to the LSP's colors
  --     vim.cmd([[
  --             highlight! semshiGlobal gui=italic
  --             highlight! semshiImported gui=bold
  --             highlight! link semshiParameter @lsp.type.parameter
  --             highlight! link semshiParameterUnused DiagnosticUnnecessary
  --             highlight! link semshiBuiltin @function.builtin
  --             highlight! link semshiAttribute @attribute
  --             highlight! link semshiSelf @lsp.type.selfKeyword
  --             highlight! link semshiUnresolved @lsp.type.unresolvedReference
  --             ]])
  --   end,
  -- })

  -- vim.api.nvim_create_autocmd("BufWritePost", {
  --   desc = "Run TSC on save",
  --   pattern = "*.ts",
  --   callback = function()
  --     vim.cmd("TSC")
  --   end,
  -- })
end
