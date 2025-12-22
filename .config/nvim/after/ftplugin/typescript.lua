-- TypeScript-specific configuration (loaded for .ts files)
-- Keymaps for ts_ls commands

local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { buffer = true, desc = 'TS: ' .. desc })
end

-- Organize imports
map('<leader>co', function()
  vim.lsp.buf.code_action({
    apply = true,
    context = { only = { 'source.organizeImports' }, diagnostics = {} },
  })
end, 'Organize Imports')

-- Remove unused imports
map('<leader>cu', function()
  vim.lsp.buf.code_action({
    apply = true,
    context = { only = { 'source.removeUnused' }, diagnostics = {} },
  })
end, 'Remove Unused')

-- Add missing imports
map('<leader>cm', function()
  vim.lsp.buf.code_action({
    apply = true,
    context = { only = { 'source.addMissingImports' }, diagnostics = {} },
  })
end, 'Add Missing Imports')

-- Fix all auto-fixable issues
map('<leader>cf', function()
  vim.lsp.buf.code_action({
    apply = true,
    context = { only = { 'source.fixAll' }, diagnostics = {} },
  })
end, 'Fix All')
