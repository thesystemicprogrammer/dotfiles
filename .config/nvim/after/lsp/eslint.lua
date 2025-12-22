-- ESLint Language Server
-- Install: npm install -g vscode-langservers-extracted

return {
  settings = {
    -- Auto-fix on save
    codeActionOnSave = {
      enable = true,
      mode = 'all',
    },
  },
  -- Auto-fix on save via autocmd (more reliable than settings)
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      command = 'silent! EslintFixAll',
    })
  end,
}
