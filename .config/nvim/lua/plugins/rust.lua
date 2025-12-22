return {
  'mrcjkb/rustaceanvim',
  version = '^6',
  lazy = false, -- Plugin is already lazy-loaded by filetype
  init = function()
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
        -- Automatically run clippy on save
        enable_clippy = true,
      },

      -- LSP configuration (replaces after/lsp/rust_analyzer.lua)
      server = {
        default_settings = {
          ['rust-analyzer'] = {
            check = {
              command = 'clippy',
            },
            cargo = {
              allFeatures = true,
            },
          },
        },
      },

      -- DAP configuration
      dap = {
        -- rustaceanvim will auto-detect codelldb if installed via Mason
      },
    }
  end,
}
