local lsp_zero = require("lsp-zero")



require('mason').setup({})
require('mason-lspconfig').setup({
	-- Replace the language servers listed here 
	-- with the ones you want to install
	ensure_installed = {'tsserver', 'eslint', 'solargraph', 'lua_ls' },
	handlers = {
		lsp_zero.default_setup,
	},
})

