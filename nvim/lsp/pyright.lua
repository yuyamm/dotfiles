local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

return {
	cmd = { "uvx", "--from", "pyright", "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
	single_file_support = true,
	capabilities = capabilities,
}
