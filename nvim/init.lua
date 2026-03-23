-- Basic settings
vim.opt.number = true
vim.opt.hlsearch = true
vim.opt.clipboard = "unnamed"
vim.opt.encoding = "UTF-8"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.history = 200

-- LSP (native Neovim 0.11+)
-- Server configs are in ~/.config/nvim/lsp/*.lua
vim.lsp.enable({ "pyright", "ruby_lsp" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	end,
})

-- Keymaps
-- Command-line mode: C-p/C-n for history navigation
vim.keymap.set("c", "<C-p>", "<Up>")
vim.keymap.set("c", "<C-n>", "<Down>")

-- Tab management
vim.keymap.set("n", "<C-Tab>", ":tabnext<CR>")
vim.keymap.set("n", "<C-S-Tab>", ":tabprevious<CR>")

-- Plugin manager: lazy.nvim
-- Auto-install lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Comment toggling (gc / gcc)
	{ "tpope/vim-commentary" },

	-- Bracket mappings ([q, ]q, etc.)
	{ "tpope/vim-unimpaired" },

	-- Surround text objects (cs, ds, ys)
	{ "tpope/vim-surround" },

	-- Fuzzy finder
	{
		"junegunn/fzf",
		build = "./install --bin",
	},
	{ "junegunn/fzf.vim" },

	-- Ruby support
	{ "vim-ruby/vim-ruby" },

	-- File explorer (oil.nvim)
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup()
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		end,
	},

	-- Treesitter (better syntax highlighting and code understanding)
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "python", "ruby", "lua", "javascript", "typescript", "json", "yaml", "html", "css", "bash", "vim", "vimdoc" },
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		},
	},

	-- Sidebar file tree (neo-tree.nvim)
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				window = {
					position = "left",
					width = 30,
				},
			})
			vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })
		end,
	},
})
