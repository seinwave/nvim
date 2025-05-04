vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- lua execution
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")
