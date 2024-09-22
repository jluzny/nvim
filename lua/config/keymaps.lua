-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

for _, mode in pairs({ "n", "v", "x" }) do
  for _, key in pairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
    vim.keymap.set(mode, key, "<nop>")
  end
end

vim.keymap.set({ "n", "x" }, "f", "e", { desc = "Add <f> as antoher key to move word forward", remap = true })

vim.keymap.set({ "n", "x" }, "d", '"_d', { desc = "Delete without copying to system clipboard", remap = false })
vim.keymap.set({ "n", "x" }, "D", '"_D', { desc = "Delete without copying to system clipboard", remap = false })
vim.keymap.set({ "n", "x" }, "c", '"_c', { desc = "Cut without copying to system clipboard", remap = false })
vim.keymap.set({ "n", "x" }, "C", '"_C', { desc = "Cut without copying to system clipboard", remap = false })
vim.keymap.set({ "n", "x" }, "X", "Vx", { desc = "Cut whole line to clipboard", remap = false })
vim.keymap.set({ "n", "x" }, "<C-S-C>", '"+y', { desc = "Copy to system clipboard", remap = true })
vim.keymap.set({ "n", "x" }, "<C-S-A>", "gg<s-v><s-g>y", { desc = "Copy whole text to system clipboard", remap = true })
vim.keymap.set({ "n" }, "<C-C>", "<cmd>close<cr>", { desc = "Close window", remap = true })

if not vim.g.vscode then
  vim.keymap.set({ "n", "i" }, "<C-Tab>", function()
    require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
  end, { desc = "Find open buffers" })

  vim.keymap.set({ "n", "i" }, "<C-S-P>", "<leader>sc", { desc = "Command history", remap = true })
  vim.keymap.set({ "n" }, "<F6>", "@:", { desc = "Rerun last command", remap = true, silent = true })
  -- Escape to normal mode in terminal
  vim.cmd("tnoremap <Esc><Esc> <C-\\><C-N>")

  vim.keymap.set({ "n" }, "<Tab>", "<cmd>wincmd w<cr>", { desc = "Switch window", remap = false })
  vim.keymap.set({ "n" }, "<S-Tab>", "<cmd>wincmd W<cr>", { desc = "Switch window back", remap = false })
  vim.keymap.set({ "n" }, "<C-P>", "<C-O>", { desc = "Next change" })
  vim.keymap.set({ "n" }, "<C-N>", "<C-I>", { desc = "Previous change" })
  vim.keymap.set({ "n" }, "<C-S-Q>", "<leader>bD", { desc = "Delete bufer", remap = true })

  vim.keymap.set({ "n", "i" }, "<C-D>", vim.diagnostic.open_float, { desc = "Line diagnostics" })
  vim.keymap.set({ "n", "i" }, "<C-S-D>", "<cmd>Trouble diagnostics<cr><tab>", { desc = "Invoke Trouble" })
  vim.keymap.set({ "n", "i" }, "<C-A>", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code action" })
  vim.keymap.set({ "n", "i" }, "<C-S-L>", "<cmd>lua vim.lsp.codelens.run()<cr>", { desc = "Code action" })

  vim.keymap.set({ "n" }, "<C-S-F>", "<leader>sr", { desc = "Replace in files", remap = true })

  vim.keymap.set({ "n", "i" }, "<C-S-E>", "<leader>e", { desc = "Explorer NeoTree (root dir)", remap = true })
end
