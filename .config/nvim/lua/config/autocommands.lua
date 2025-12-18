-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('tomber-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Open task terminal on the right when dashboard opens
vim.api.nvim_create_autocmd('User', {
  pattern = 'SnacksDashboardOpened',
  group = vim.api.nvim_create_augroup('dashboard-task-terminal', { clear = true }),
  callback = function()
    -- Small delay to let dashboard render first
    vim.defer_fn(function()
      local snacks = require('snacks')
      snacks.terminal.open('task', {
        win = {
          position = 'right',
          width = 0.5,
        },
      })
    end, 100)
  end,
})
