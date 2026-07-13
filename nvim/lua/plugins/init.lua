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

	-- Surround text objects (cs, ds, ys)
	{ "tpope/vim-surround" },

	-- Window resize mode
	{
		"simeji/winresizer",
		init = function()
			vim.g.winresizer_start_key = "<C-w>e"
		end,
	},

	-- Fuzzy finder
	{
		"junegunn/fzf",
		build = "./install --bin",
	},
	{ "junegunn/fzf.vim" },

	-- Colorscheme
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				theme = "wave",
			})
			vim.cmd.colorscheme("kanagawa")
		end,
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
				},
			})
		end,
	},

	-- Git commands and file history
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })
			vim.keymap.set("n", "<leader>gB", "<cmd>Git blame<CR>", { desc = "Git blame" })
			vim.keymap.set("n", "<leader>gh", "<cmd>Gclog -- %<CR><cmd>copen<CR>", { desc = "Git file history" })
		end,
	},

	-- Git signs in the gutter
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")

			gitsigns.setup({
				on_attach = function(bufnr)
					local opts = { buffer = bufnr }
					vim.keymap.set("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(gitsigns.next_hunk)
						return "<Ignore>"
					end, { expr = true, buffer = bufnr, desc = "Next git hunk" })
					vim.keymap.set("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(gitsigns.prev_hunk)
						return "<Ignore>"
					end, { expr = true, buffer = bufnr, desc = "Previous git hunk" })
					vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, opts)
					vim.keymap.set("n", "<leader>gb", gitsigns.blame_line, opts)
				end,
			})
		end,
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

	-- Treesitter (better syntax highlighting and code understanding)
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "python", "lua", "dart", "javascript", "typescript", "json", "yaml", "html", "css", "bash", "markdown", "markdown_inline", "vim", "vimdoc" },
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		},
	},
})
