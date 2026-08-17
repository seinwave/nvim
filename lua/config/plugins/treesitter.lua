return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()
      require("nvim-treesitter").install({
        "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "ruby", "java", "typescript", "javascript",
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "lua", "vim", "markdown", "ruby", "java", "typescript", "javascript" },
        callback = function() vim.treesitter.start() end,
      })
    end,
  }
}
