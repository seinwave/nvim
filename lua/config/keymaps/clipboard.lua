vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.opt.clipboard = "unnamedplus"

-- Copy to clipboard
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>Y', '"+yg_', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>yy', '"+yy', { noremap = true })

-- Paste from clipboard
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>P', '"+P', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>P', '"+P', { noremap = true })

function copy_relative_path()
  -- Find the root directory
  local root_dir = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print("Not in a git repository")
    return
  end

  -- Get the absolute path of the current buffer
  local abs_path = vim.fn.expand('%:p')

  -- Get the relative path
  local rel_path = abs_path:sub(#root_dir + 2)

  -- Copy the relative path to the clipboard
  vim.fn.setreg('+', rel_path)
end

vim.api.nvim_set_keymap('n', '<leader>c', ':lua copy_relative_path()<CR>', { noremap = true, silent = true })
