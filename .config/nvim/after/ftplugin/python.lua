-- Python-specific configuration (loaded for .py files)
-- Keymaps for nvim-dap-python

local map = function(keys, func, desc, mode)
  mode = mode or 'n'
  vim.keymap.set(mode, keys, func, { buffer = true, desc = 'Python: ' .. desc })
end

-- Test debugging
map('<leader>dm', function() require('dap-python').test_method() end, 'Debug Test Method')
map('<leader>dC', function() require('dap-python').test_class() end, 'Debug Test Class')
map('<leader>ds', function() require('dap-python').debug_selection() end, 'Debug Selection', 'v')
