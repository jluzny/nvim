-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufNew", {
  desc = "Python projects: auto select virtualenv Nvim open, and VS Code launch.json config activation",
  pattern = "*.py",
  callback = function()
    local pyproject = vim.fn.findfile("pyproject.toml", ".;")
    if pyproject ~= "" then
      require("venv-selector").retrieve_from_cache()
      require("dap.ext.vscode").load_launchjs()
    end
  end,
  once = true,
})

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  group = vim.api.nvim_create_augroup("SemanticHighlight", {}),
  callback = function()
    -- Only add style, inherit or link to the LSP's colors
    vim.cmd([[
            highlight! semshiGlobal gui=italic
            highlight! semshiImported gui=bold
            highlight! link semshiParameter @lsp.type.parameter
            highlight! link semshiParameterUnused DiagnosticUnnecessary
            highlight! link semshiBuiltin @function.builtin
            highlight! link semshiAttribute @attribute
            highlight! link semshiSelf @lsp.type.selfKeyword
            highlight! link semshiUnresolved @lsp.type.unresolvedReference
            ]])
  end,
})

vim.api.nvim_create_autocmd("BufReadPre", {
  desc = "Open neo-tree on enter",
  callback = function()
    if not vim.g.neotree_opened then
      vim.cmd("Neotree show")
      vim.g.neotree_opened = true
    end
  end,
})
