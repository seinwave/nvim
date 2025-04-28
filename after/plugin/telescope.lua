local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
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
