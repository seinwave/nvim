local builtin = require('telescope.builtin')
local float_input = require('config.float_input')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  float_input.input({ prompt = "Grep" }, function(input)
    if input then builtin.grep_string({ search = input }) end
  end)
end);

vim.keymap.set('n', '<leader>pc', function()
  builtin.find_files {
    prompt_title = "Your Nvim Config",
    cwd = vim.fn.stdpath("config")
  }
end)

vim.keymap.set('n', '<leader>pp', function()
  builtin.find_files {
    prompt_title = "Vim Plugin Files",
    cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
  }
end)

vim.keymap.set('n', '<leader>;', function()
  builtin.commands {
    layout_strategy = "center",
    layout_config = { width = 0.5, height = 0.5 },
  }
end, { desc = "Command palette" })
