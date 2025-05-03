return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      require("mason").setup {}

      require("mason-lspconfig").setup({
        ensure_installed = {
          'lua_ls',
          'eslint',
          'html',
          'cssls',
          'ts_ls',
          'jdtls',
          'marksman',
        },
        automatic_installation = false
      })

      -- add blink's autocomplete to LSPs
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      lspconfig.lua_ls.setup { capabiliies = capabilities }
      lspconfig.ts_ls.setup { capabiliies = capabilities }
      lspconfig.eslint.setup { capabilities = capabilities }
      lspconfig.cssls.setup { capabiliies = capabilities }
      lspconfig.html.setup { capabiliies = capabilities }
      lspconfig.marksman.setup { capabilities = capabilities }

      -- Ruby and Java configurations — do NOT use Mason to manage these
      lspconfig.ruby_lsp.setup {
        cmd = { 'ruby-lsp' },
        filetypes = { 'ruby', 'eruby' },
        init_options = {
          formatter = 'standard',
          linters = { 'standard' },
          addonSettings = {
            ["Ruby LSP Rails"] = {
              enablePendingMigrationsPrompt = false,
            },
          },
          capabilities = capabilities } }

      lspconfig.jdtls.setup {
        cmd = {
          '/Library/Java/JavaVirtualMachines/jdk-24.0.1.jdk/Contents/Home/'
        },
        settings = {
          java = {
            configuration = {
              -- jdtls requires > 21 to run, but your projects are on Java 17
              runtimes = {
                {
                  name = "JavaSE-17",
                  path = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home",
                },
                {
                  name = "JavaSE-24",
                  path = "/Library/Java/JavaVirtualMachines/jdk-24.0.1.jdk/Contents/Home",
                },
              } } } },
        capabilities = capabilities }

      -- LSP key-mappings
      local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', { clear = true })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = lsp_cmds,
        desc = 'LSP actions',
        callback = function()
          local bufmap = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = true })
          end

          bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
          bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
          bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
          bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
          bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
          bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
          bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
          bufmap('n', 'vrn', '<cmd>lua vim.lsp.buf.rename()<cr>')
          bufmap({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
          bufmap('n', 'vca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
          bufmap('n', 'fd', '<cmd>lua vim.diagnostic.open_float()<cr>')
          bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
          bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
        end
      })


      -- format-on-save with conform TODO: add LSPs / formatters
      require("conform").setup({
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end

  }
}
