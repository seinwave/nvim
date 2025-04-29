vim.g.mapleader = " "

local cwd = vim.uv.cwd()
vim.keymap.set("n", "<leader>pv", "<CMD>Oil --float " .. cwd .. "<CR>", { desc = "Open Oil (float) at CWD" })

-- lua execution
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")
