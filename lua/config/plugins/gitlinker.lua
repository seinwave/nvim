return {
  "ruifm/gitlinker.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>gl", function() require("gitlinker").get_buf_range_url("n") end, mode = "n", desc = "Copy GitHub link" },
    { "<leader>gl", function() require("gitlinker").get_buf_range_url("v") end, mode = "v", desc = "Copy GitHub link (selection)" },
  },
  opts = {
    mappings = nil, -- disable default <leader>gy mapping
  },
}
