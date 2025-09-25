return {
  "junegunn/goyo.vim",
  cmd = "Goyo",
  config = function()
    vim.g.goyo_width = 100
    vim.g.goyo_height = 85
    vim.g.goyo_linenr = 1

    local function goyo_enter()
      vim.opt.wrap = true
      vim.opt.linebreak = true
      vim.opt.list = false
      vim.opt.textwidth = 0
      vim.opt.wrapmargin = 0
      vim.opt.breakindent = true
      vim.opt.relativenumber = true

      local opts = { buffer = true, noremap = true }
      vim.keymap.set('n', 'j', 'gj', opts)
      vim.keymap.set('n', 'k', 'gk', opts)
      vim.keymap.set('n', '0', 'g0', opts)
      vim.keymap.set('n', '$', 'g$', opts)
      vim.keymap.set('n', '^', 'g^', opts)
    end

    local function goyo_leave()
      vim.opt.wrap = false
      vim.opt.breakindent = false
      vim.opt.showbreak = ""
      vim.opt.relativenumber = true
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'GoyoEnter',
      callback = goyo_enter,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'GoyoLeave',
      callback = goyo_leave,
    })
  end,
}
