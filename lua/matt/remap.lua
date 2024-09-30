vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


-- Formatting
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

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

-- move between panes
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', { noremap = true, silent = true })


-- move between panes, specifically for Fugitive buffers 
vim.cmd [[
  augroup fugitive_mappings
    autocmd!
    autocmd FileType fugitive nmap <buffer> <C-k> <C-w>k
    autocmd FileType fugitive nmap <buffer> <C-j> <C-w>j
    autocmd FileType fugitive nmap <buffer> <C-h> <C-w>h
    autocmd FileType fugitive nmap <buffer> <C-l> <C-w>l
  augroup END
]]


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

vim.api.nvim_set_keymap('n', '<leader>k', ':lua copy_relative_path()<CR>', {noremap = true, silent = true})
