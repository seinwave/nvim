local lsp_zero = require("lsp-zero")
local cmp = require('cmp');
local cmp_select = require('lsp-zero').cmp_select;

cmp.setup({

	mapping = cmp.mapping.preset.insert({

		['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
		['<C-y>'] = cmp.mapping.confirm({ select = true }),
	}),
});



lsp_zero.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
	vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end, opts)
	vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "<leader>[", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "<leader>]", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

        -- Split mappings
	vim.keymap.set("n", "<leader>vs", function() vim.cmd('split') end, opts) -- Open a horizontal split
	vim.keymap.set("n", "<leader>vv", function() vim.cmd('vsplit') end, opts) -- Open a vertical split
	vim.keymap.set("n", "<leader>q", function() vim.cmd('q') end, opts) -- Close a split
	vim.keymap.set("n", "<leader>h", function() vim.cmd('wincmd h') end, opts) -- Navigate to the left split
	vim.keymap.set("n", "<leader>j", function() vim.cmd('wincmd j') end, opts) -- Navigate to the bottom split
	vim.keymap.set("n", "<leader>k", function() vim.cmd('wincmd k') end, opts) -- Navigate to the top split
	vim.keymap.set("n", "<leader>l", function() vim.cmd('wincmd l') end, opts) -- Navigate to the right spli
end)



require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = { 'tsserver', 'eslint', 'solargraph', 'lua_ls', 'jsonls', 'marksman', 'yamlls', 'bashls', 'cssls', 'jdtls' },
	handlers = {
		lsp_zero.default_setup,
		lua_ls = function()
			local lua_opts = lsp_zero.nvim_lua_ls()
			require('lspconfig').lua_ls.setup(lua_opts)
		end,
	},


})
