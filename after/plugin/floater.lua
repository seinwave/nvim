-- Function to create a centered floating window
function _G.create_centered_float()
  -- Get the current editor dimensions
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  
  -- Calculate window size (65% of screen)
  local win_width = math.floor(width * 0.65)
  local win_height = math.floor(height * 0.65)
  
  -- Calculate starting position to center the window
  local row = math.floor((height - win_height) / 2)
  local col = math.floor((width - win_width) / 2)
  
  -- Set some buffer options
  local buf = vim.api.nvim_create_buf(false, true)
  
  -- Configure the window options
  local opts = {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded"
  }
  
  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, opts)
  
  -- Optional: Set window-local options
  vim.api.nvim_win_set_option(win, "winblend", 0)
  vim.cmd('startinsert')
  return buf, win
end

-- Create a user command to invoke the floating window
vim.api.nvim_create_user_command('FloatWin', function()
  _G.create_centered_float()
end, {})

vim.keymap.set("n", "<leader>fw", function()
	vim.cmd('FloatWin')
end)
