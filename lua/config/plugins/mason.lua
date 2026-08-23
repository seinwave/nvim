return {
  { "williamboman/mason.nvim", opts = {} },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        'lua_ls',
        'eslint',
        'html',
        'cssls',
        'ts_ls',
        'marksman',
      },
    },
  },
}
