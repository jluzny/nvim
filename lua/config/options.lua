-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if not vim.g.vscode then
  local opt = vim.opt

  -- code folding
  -- opt.foldlevel = 20
  -- opt.foldmethod = "expr"
  -- opt.foldexpr = "nvim_treesitter#foldexpr()"
  -- opt.foldenable = true

  --enable/diasble auto paste to/from system clipboard
  opt.clipboard = "unnamedplus"
  opt.wrap = true
  opt.linebreak = true
  opt.showbreak = "↪ "
end
