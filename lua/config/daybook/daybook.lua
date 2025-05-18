local M = {}

M.config = {
  file_path = vim.fn.expand('~/daybook.md'),
  window = {
    width = 0.5,
    height = 0.7,
    border = 'rounded',
    title = ' Daybook ',
  },
}

local function get_formatted_date()
  return os.date("%A, %B %d, %Y")
end
   Taking notes is hard in here

local function has_todays_header(bufnr)
  local today = get_formatted_date()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for _, line in ipairs(lines) do
    if line == "## " .. today then
      return true
    end
  end

  return false
end

local function create_floating_window(bufnr)
  local width = math.floor(vim.api.nvim_get_option_value("columns", {}) * M.config.window.width)
  local height = math.floor(vim.api.nvim_get_option_value("lines", {}) * M.config.window.height)

  local row = math.floor((vim.api.nvim_get_option_value("lines", {}) - height) / 2)
  local col = math.floor((vim.api.nvim_get_option_value("columns", {}) - width) / 2)

  local opts = {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    style = "minimal",
    border = M.config.window.border,
    title = M.config.window.title,
  }

  return vim.api.nvim_open_win(bufnr, true, opts)
end


function M.open()
  local file_exists = vim.fn.filereadable(M.config.file_path) == 1

  local bufnr
  if file_exists then
    bufnr = vim.fn.bufadd(M.config.file_path)
    vim.fn.bufload(bufnr)
  else
    vim.fn.mkdir(vim.fn.fnamemodify(M.config.file_path, ":h"), "p")
    print("Dir is: ", vim.fn.fnamemodify(M.config.file_path, ":h"))
    bufnr = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_name(bufnr, M.config.file_path)
  end

  local win_id = create_floating_window(bufnr)

  if not has_todays_header(bufnr) then
    local today = get_formatted_date()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    if #lines > 0 and lines[#lines] ~= "" then
      vim.api.nvim_buf_set_lines(bufnr, #lines, #lines, false, { "" })
    end

    vim.api.nvim_buf_set_lines(
      bufnr,
      #vim.api.nvim_buf_get_lines(bufnr, 0, -1, false),
      #vim.api.nvim_buf_get_lines(bufnr, 0, -1, false),
      false,
      { "## " .. today, "" }
    )
  end

  vim.api.nvim_set_option_value("filetype", "markdown", { buf = bufnr })
  vim.api.nvim_set_option_value("swapfile", false, { buf = bufnr })

  vim.api.nvim_set_option_value("wrap", true, { win = win_id })
  vim.api.nvim_set_option_value("linebreak", true, { win = win_id })
  vim.api.nvim_set_option_value("breakindent", true, { win = win_id })

  local win_width = vim.api.nvim_win_get_width(win_id)
  vim.api.nvim_set_option_value("textwidth", win_width - 4, { buf = bufnr })

  -- set up highlighting, when you can
  vim.api.nvim_set_hl(0, "DaybookDateLine", { bold = true, fg = "#7DAEA3" })

  local line_count = #vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  vim.api.nvim_win_set_cursor(win_id, { line_count, 0 })

  vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":q<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<ESC>", ":q<CR>", { noremap = true, silent = true })
end

function M.setup(opts)
  if opts then
    M.config = vim.tbl_deep_extend("force", M.config, opts)
  end

  vim.api.nvim_create_user_command("Daybook", M.open, {})

  -- set up bolding, background color
  vim.api.nvim_set_hl(0, "DaybookDateLine", { bold = true, fg = "#7DAEA3" })
end

return M
