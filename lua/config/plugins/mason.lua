return {
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
    end
  }
}
