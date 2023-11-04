-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

for _, mode in pairs({ "n", "v", "x" }) do
  for _, key in pairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
    vim.keymap.set(mode, key, "<nop>")
  end
end

if not vim.g.vscode then
  vim.keymap.set({ "n", "i" }, "<C-Tab>", function()
    require("telescope.builtin").oldfiles({ cwd_only = true })
  end, { desc = "Find Recent files" })

  vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without copying to system clipboard", remap = false })
  vim.keymap.set({ "n", "v" }, "D", '"_D', { desc = "Delete without copying to system clipboard", remap = false })
  vim.keymap.set({ "n", "v" }, "c", '"_c', { desc = "Cut without copying to system clipboard", remap = false })
  vim.keymap.set({ "n", "v" }, "C", '"_C', { desc = "Cut without copying to system clipboard", remap = false })
  vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Erase without copying to system clipboard", remap = false })
  vim.keymap.set({ "n", "v" }, "<C-S-C>", '"+y', { desc = "Copy to system clipboard", remap = true })

  vim.keymap.set({ "n", "i" }, "<C-S-P>", "<leader>sc", { desc = "Command history", remap = true })

  vim.keymap.set({ "n", "i" }, "<C-C>", "<cmd>close<cr>", { desc = "Close window", remap = true })
  vim.keymap.set({ "n", "i" }, "<Tab>", "<cmd>wincmd w<cr>", { desc = "Switch window", remap = true })
  vim.keymap.set({ "n", "i" }, "<S-Tab>", "<cmd>wincmd W<cr>", { desc = "Switch window back", remap = true })
  -- vim.keymap.set({ "n", "i" }, "<C-Q>", "<cmd>close<cr>", { desc = "Close window", remap = true })
  vim.keymap.set({ "n", "i" }, "<C-S-Q>", "<cmd>bd<cr>", { desc = "Delete bufer", remap = true })

  vim.keymap.set({ "n", "i" }, "<C-S-D>", vim.diagnostic.open_float, { desc = "Line diagnostics" })
  vim.keymap.set({ "n", "i" }, "<C-S-A>", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Code action" })
  vim.keymap.set({ "n", "i" }, "<C-S-L>", "<cmd>lua vim.lsp.codelens.run()<cr>", { desc = "Code action" })

  vim.keymap.set({ "n" }, "<C-S-F>", function()
    require("spectre").open()
  end, { desc = "Replace in files (Spectre)" })

  vim.keymap.set({ "n", "i" }, "<C-S-E>", "<leader>e", { desc = "Explorer NeoTree (root dir)", remap = true })
  -- require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
  -- end, { desc = "Explorer NeoTree (root dir)" })

  -- vim.keymap.set({ "n", "i" }, "<C-S-F>", function()
  --   require("lazyvim.plugins.lsp.format").format({ force = true })
  -- end, { desc = "Format code" })

  -- ChatGPT
  -- vim.keymap.set("n", "<C-CR>", require("chatgpt").complete_code)
  -- vim.keymap.set("i", "<C-CR>", "<Esc>:ChatGPTCompleteCode<CR>")
end
