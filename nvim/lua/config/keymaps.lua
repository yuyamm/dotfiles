-- Command-line mode: C-p/C-n for history navigation
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")

-- Tab management
vim.keymap.set("n", "<C-Tab>", ":tabnext<CR>")
vim.keymap.set("n", "<C-S-Tab>", ":tabprevious<CR>")
