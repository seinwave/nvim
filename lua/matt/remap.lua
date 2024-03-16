vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


-- Formatting
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
