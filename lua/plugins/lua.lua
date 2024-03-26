if true or vim.g.vscode then
  return {}
end

return {
  { import = "lazyvim.plugins.extras.dap.nlua" },
}
