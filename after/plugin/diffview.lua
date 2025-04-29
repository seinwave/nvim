-- defaults to comparing against current index
vim.keymap.set('n', '<leader>dv', function()
  vim.cmd("DiffviewOpen")
end)

vim.keymap.set('n', '<leader>dvm', function()
  vim.cmd("DiffviewOpen origin/main...HEAD")
end)
