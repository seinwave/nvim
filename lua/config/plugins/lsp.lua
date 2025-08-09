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

      local function on_attach(client, bufnr)
        local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
        if (client.name == "tsserver" or client.name == "ts_ls") and (filetype == "typescript" or filetype == "typescriptreact" or filetype == "javascript" or filetype == "javascriptreact") then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end
      end

      -- add blink's autocomplete to LSPs
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      lspconfig.lua_ls.setup { capabilities = capabilities }
      lspconfig.ts_ls.setup { on_attach = on_attach, capabilities = capabilities }
      lspconfig.eslint.setup { on_attach = on_attach, capabilities = capabilities }
      lspconfig.cssls.setup { capabilities = capabilities }
      lspconfig.html.setup { capabilities = capabilities }
      lspconfig.marksman.setup { capabilities = capabilities }

      lspconfig.sourcekit.setup {
        cmd = { '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp' },
        filetypes = { "swift", "objective-c", "objective-cpp" },
        capabilities = capabilities,
        on_attach = on_attach,
      }

      -- Ruby and Java configurations — do NOT use Mason to manage these
      lspconfig.ruby_lsp.setup {
        cmd = { 'ruby-lsp' },
        filetypes = { 'ruby', 'eruby' },
        capabilities = capabilities,
        init_options = {
          formatter = 'standard',
          linters = { 'standard' },
          addonSettings = {
            ["Ruby LSP Rails"] = {
              enablePendingMigrationsPrompt = false,
            },
          },
        }
      }

      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "Podfile", "Podfile.*", "Fastfile", "Fastfile.*" },
        command = 'set filetype=ruby'
      })

      lspconfig.jdtls.setup {
        cmd = {
          '/Library/Java/JavaVirtualMachines/jdk-24.0.1.jdk/Contents/Home/'
        },
        env = { JAVA_HOME = "/Library/Java/JavaVirtualMachines/jdk-24.0.1.jdk/Contents/Home" },
        settings = {
          java = {
            configuration = {
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


      require("conform").setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          javascript = { "eslint_d", "prettier" },
          javascriptreact = { "eslint_d", "prettier" },
          typescript = { "eslint_d", "prettier" },
          typescriptreact = { "eslint_d", "prettier" },
          swift = { "swift_format" },
        },
      })
    end

  }
}
