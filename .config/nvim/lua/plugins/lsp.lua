return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },

    -- Useful status updates for LSP.
    { 'j-hui/fidget.nvim', opts = {} },

    -- Allows extra capabilities provided by blink.cmp
    'saghen/blink.cmp',
  },
  config = function()
    -- LSP Configuration
    --
    -- Language servers are configured in individual files under after/lsp/
    -- Each server is enabled via vim.lsp.enable() which provides automatic
    -- filetype-based activation using standard configs from nvim-lspconfig.
    --
    -- See LSP_INSTALL.md for installation instructions for each language server.

    -- This function gets run when an LSP attaches to a particular buffer.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename the variable under your cursor.
        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

        -- Find references for the word under your cursor.
        map('grr', require('snacks').picker.lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        map('gri', require('snacks').picker.lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the definition of the word under your cursor.
        map('grd', require('snacks').picker.lsp_definitions, '[G]oto [D]efinition')

        -- Jump to declaration (e.g., header in C).
        map('grD', require('snacks').picker.lsp_declarations, '[G]oto [D]eclaration')

        -- Fuzzy find all the symbols in your current document.
        map('grs', require('snacks').picker.lsp_symbols, 'Open LSP Symbols')

        -- Fuzzy find all the symbols in your current workspace.
        map('grS', require('snacks').picker.lsp_workspace_symbols, 'Open LSP Workspace Symbols')

        -- Jump to the type of the word under your cursor.
        map('grt', require('snacks').picker.lsp_type_definitions, '[G]oto [T]ype Definition')

        map('gai', require('snacks').picker.lsp_incoming_calls, 'Calls Incoming')
        map('gao', require('snacks').picker.lsp_outgoing_calls, 'Calls Outgoing')

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Document highlighting
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
            end,
          })
        end

        -- Inlay hints toggle
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- Diagnostic Config
    vim.diagnostic.config({
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      },
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          return diagnostic.message
        end,
      },
    })

    -- Set capabilities globally for all LSP servers
    -- This uses the wildcard '*' pattern to apply to all servers
    vim.lsp.config('*', {
      capabilities = require('blink.cmp').get_lsp_capabilities(),
    })

    -- Enable all LSP servers
    -- Server configs are defined in after/lsp/<name>.lua (overrides nvim-lspconfig defaults)
    -- Note: jdtls is enabled separately in lua/plugins/java.lua
    -- Note: rust_analyzer is handled by rustaceanvim (lua/plugins/rust.lua)
    vim.lsp.enable({
      'angularls',
      'bashls',
      'eslint',
      'gopls',
      'jsonls',
      'lua_ls',
      'marksman',
      'pyright',
      'taplo',
      'tinymist',
      'ts_ls',
      'yamlls',
    })
  end,
}
