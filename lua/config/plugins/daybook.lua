return {

  {
    "daybook",
    dir = vim.fn.stdpath("config") .. "/lua/config/daybook",
    config = function()
      require "config.daybook.daybook".setup({
        file_path = vim.fn.expand('~/daybook.md'),
        window = {
          width = 0.5,
          height = 0.7,
          border = "rounded",
          title = " Daybook ",
        }
      })
    end,
    keys = {
      { "<leader>db", ":Daybook<CR>", desc = "Open Daybook" },
    },
  }
}
