vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", "<CMD>Oil --float<CR>", { desc = "Open Oil (float) at CWD" })
vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open Oil (float) at CWD" })

-- lua execution
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

-- file stuff
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>so", ":so<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")

vim.keymap.set("n", "<leader>wq", ":wq<CR>")

-- colorschemes
vim.keymap.set("n", "<leader>csp", ":colorscheme paper<CR>", { desc = "Colorscheme: paper" })
vim.keymap.set("n", "<leader>cskd", ":colorscheme kanagawa-wave<CR>", { desc = "Colorscheme: kanagawa dark" })
vim.keymap.set("n", "<leader>cskl", ":colorscheme kanagawa-lotus<CR>", { desc = "Colorscheme: kanagawa light" })
