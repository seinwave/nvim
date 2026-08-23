return {
  'stevearc/conform.nvim',
  opts = {
    -- edx is a legacy-formatted monolith; formatting there is enforced by
    -- spotless on an allowlist only. Never format-on-save inside it.
    format_on_save = function(bufnr)
      if vim.api.nvim_buf_get_name(bufnr):match("/work/edx/") then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    formatters_by_ft = {
      java = { "google-java-format" },
      javascript = { "eslint_d", "prettier" },
      javascriptreact = { "eslint_d", "prettier" },
      typescript = { "eslint_d", "prettier" },
      typescriptreact = { "eslint_d", "prettier" },
      swift = { "swift_format" },
    },
  },
}
