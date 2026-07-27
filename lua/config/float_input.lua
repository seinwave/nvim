local M = {}

function M.input(opts, on_confirm)
  local prompt = opts.prompt or "Input"
  local width = opts.width or 40

  local buf = vim.api.nvim_create_buf(false, true)
  local lines = vim.api.nvim_get_option_value("lines", {})
  local columns = vim.api.nvim_get_option_value("columns", {})

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = 1,
    row = math.floor((lines - 1) / 2),
    col = math.floor((columns - width) / 2),
    style = "minimal",
    border = "rounded",
    title = " " .. prompt .. " ",
    title_pos = "center",
  })

  vim.cmd("startinsert")

  local function close(text)
    vim.api.nvim_win_close(win, true)
    vim.schedule(function()
      vim.cmd("stopinsert")
      on_confirm(text)
    end)
  end

  vim.keymap.set("i", "<CR>",  function()
    local text = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or ""
    close(text ~= "" and text or nil)
  end, { buffer = buf, nowait = true })

  vim.keymap.set({ "i", "n" }, "<ESC>", function() close(nil) end, { buffer = buf, nowait = true })
end

return M
