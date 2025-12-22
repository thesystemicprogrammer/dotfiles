-- Go-specific configuration (loaded for .go files)
-- Keymaps for nvim-dap-go

local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { buffer = true, desc = 'Go: ' .. desc })
end

-- Test debugging
map('<leader>dm', function() require('dap-go').debug_test() end, 'Debug Test Method')
map('<leader>dL', function() require('dap-go').debug_last_test() end, 'Debug Last Test')
