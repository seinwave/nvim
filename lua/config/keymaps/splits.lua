-- move between splits
vim.api.nvim_set_keymap('n', '<leader>k', ':wincmd k<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>j', ':wincmd j<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':wincmd l<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>l', ':wincmd l<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>s', ':split<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sv', ':vsplit<CR>', { noremap = true, silent = true })

-- managing split sizing
-- todo: add bindings for your split keeb
vim.api.nvim_set_keymap("n", "<leader>,", "<c-w>5<", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>.", "<c-w>5>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>p", "<C-W>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>;", "<C-W>-", { noremap = true, silent = true })
