-- Command-line mode: C-p/C-n for history navigation
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")

-- Tab management
vim.keymap.set("n", "<C-Tab>", ":tabnext<CR>")
vim.keymap.set("n", "<C-S-Tab>", ":tabprevious<CR>")
vim.keymap.set("n", "<C-w>t", "<cmd>tab split<CR>", { desc = "Open current window in new tab" })

-- Buffer navigation
vim.keymap.set("n", "<C-b>", "<cmd>ls<CR>", { desc = "List buffers" })
vim.keymap.set("n", "<C-n>", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<C-p>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<C-x>", "<cmd>bd<CR>", { desc = "Delete buffer" })

-- Terminal navigation
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
