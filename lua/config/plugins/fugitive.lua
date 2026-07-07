return {
  "tpope/vim-fugitive",
  config = function()
    -- Move status and commit windows to a vertical split on the right
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "fugitive", "gitcommit" },
      callback = function()
        vim.cmd("wincmd L")
      end,
    })

    -- Make :Gdiff open a vertical diff split
    vim.api.nvim_create_autocmd("BufReadPost", {
      pattern = "fugitive://*",
      callback = function()
        vim.cmd("wincmd L")
      end,
    })

    vim.keymap.set("n", "<leader>gp", ":Git pull<CR>", { silent = true, desc = "Git pull" })
    vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { silent = true, desc = "Git diff" })
  end,
}
