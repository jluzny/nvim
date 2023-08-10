-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

for _, mode in pairs({ "n", "v", "x" }) do
  for _, key in pairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
    vim.keymap.set(mode, key, "<nop>")
  end
end

vim.keymap.set({ "n", "i" }, "<C-S-D>", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

vim.keymap.set({ "n" }, "<C-S-F>", function()
  require("spectre").open()
end, { desc = "Replace in files (Spectre)" })

-- vim.keymap.set({ "n", "i" }, "<C-S-F>", function()
--   require("lazyvim.plugins.lsp.format").format({ force = true })
-- end, { desc = "Format code" })

-- Debug keymapping
-- vim.keymap.set("n", "<C-S-F5>", require("dap").run_last)
vim.keymap.set("n", "<F5>", require("dap").continue)
-- vim.keymap.set("n", "<S-F5>", require("dap").terminate)
-- vim.keymap.set("n", "<F9>", require("dap").toggle_breakpoint)
vim.keymap.set("n", "<F9>", require("persistent-breakpoints.api").toggle_breakpoint)
vim.keymap.set("n", "<F10>", require("dap").step_over)
vim.keymap.set("n", "<F11>", require("dap").step_into)
vim.keymap.set("n", "<F12>", require("dap").step_out)

-- ChatGPT
-- vim.keymap.set("n", "<C-CR>", require("chatgpt").complete_code)
-- vim.keymap.set("i", "<C-CR>", "<Esc>:ChatGPTCompleteCode<CR>")
