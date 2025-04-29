vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
vim.keymap.set("n", "<leader>ga", function()
  vim.cmd("Git add .")
end)
vim.keymap.set("n", "<leader>gc", function()
  vim.cmd("Git commit")
end)
vim.keymap.set("n", "<leader>gpo", function()
  local branch = vim.fn.trim(vim.fn.system("Git branch --show-current"))
  vim.cmd("Git push origin " .. branch)
end)
vim.keymap.set("n", "<leader>gbg", function()
  -- default to 'ms', for all my work at EH
  local regex = vim.fn.input("Look for (default-- ms): ")

  if regex == "" then
    regex = "ms"
  end

  print(regex)

  vim.cmd("Git branch")

  vim.defer_fn(function()
    local buf = vim.api.nvim_get_current_buf()

    vim.cmd("setlocal modifiable")
    vim.cmd("silent! v/" .. regex .. "/d")

    local lines_after = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    if #lines_after == 0 or (#lines_after == 1 and lines_after[1] == "") then
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
      local message = {
        "No branches matching '" .. regex .. "' were found.",
        "",
        "You might want to try:",
        "- A different search term",
        "- Checking if you're in a git repository",
        "- Running 'git fetch' to update remote branches",
        "",
        "Press 'q' to close this buffer."
      }
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, message)
    else
      local header = { "Branches matching '" .. regex .. "':", "" }
      vim.api.nvim_buf_set_lines(buf, 0, 0, false, header)
    end

    vim.cmd("setlocal nomodifiable")
    vim.cmd("file Git_Branches:" .. regex)
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':bd<CR>', { noremap = true, silent = true })
  end, 200)
end)
