vim.keymap.set("n", "<leader>t", function()
  vim.cmd(":tabnext")
end)

vim.keymap.set("n", "<leader>tn", function()
  vim.cmd(":tabnew")
end)

vim.keymap.set("n", "<leader>tc", function()
  vim.cmd(":tabclose")
end)
