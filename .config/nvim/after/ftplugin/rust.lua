-- Rust-specific configuration (loaded for .rs files)
-- Keymaps for rustaceanvim commands

local map = function(keys, cmd, desc)
  vim.keymap.set('n', keys, cmd, { buffer = true, desc = 'Rust: ' .. desc })
end

-- Code actions and hover (enhanced versions from rustaceanvim)
map('<leader>ra', function() vim.cmd.RustLsp('codeAction') end, 'Code Action')
map('K', function() vim.cmd.RustLsp({ 'hover', 'actions' }) end, 'Hover Actions')

-- Run and Debug
map('<leader>rr', function() vim.cmd.RustLsp('runnables') end, 'Runnables')
map('<leader>rd', function() vim.cmd.RustLsp('debuggables') end, 'Debuggables')
map('<leader>rl', function() vim.cmd.RustLsp({ 'runnables', bang = true }) end, 'Run Last')

-- Testing
map('<leader>rt', function() vim.cmd.RustLsp('testables') end, 'Testables')

-- Cargo
map('<leader>rc', function() vim.cmd.RustLsp('openCargo') end, 'Open Cargo.toml')

-- Code exploration
map('<leader>rm', function() vim.cmd.RustLsp('expandMacro') end, 'Expand Macro')
map('<leader>rp', function() vim.cmd.RustLsp('parentModule') end, 'Parent Module')
map('<leader>rk', function() vim.cmd.RustLsp('openDocs') end, 'Open docs.rs')

-- Diagnostics
map('<leader>re', function() vim.cmd.RustLsp('explainError') end, 'Explain Error')
map('<leader>rD', function() vim.cmd.RustLsp('renderDiagnostic') end, 'Render Diagnostic')

-- Join lines (smart join for Rust)
map('J', function() vim.cmd.RustLsp('joinLines') end, 'Join Lines')

-- Crate graph (requires graphviz)
map('<leader>rg', function() vim.cmd.RustLsp({ 'crateGraph', '[svg]' }) end, 'Crate Graph')

-- Syntax tree (for debugging)
map('<leader>rs', function() vim.cmd.RustLsp('syntaxTree') end, 'Syntax Tree')
