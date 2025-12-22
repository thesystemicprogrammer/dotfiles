return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Mason for managing debug adapters
    {
      'williamboman/mason.nvim',
      opts = {},
    },

    -- Mason integration for auto-installing debug adapters
    {
      'jay-babu/mason-nvim-dap.nvim',
      dependencies = { 'williamboman/mason.nvim' },
      opts = {
        ensure_installed = {
          'codelldb', -- Rust, C, C++
          'debugpy', -- Python
          'delve', -- Go
          'bash-debug-adapter', -- Bash
        },
        -- Use default handlers for automatic adapter configuration
        handlers = {},
      },
    },

    -- Minimalistic debug UI (requires nvim 0.11+)
    {
      'igorlfs/nvim-dap-view',
      opts = {
        windows = {
          terminal = {
            -- Hide terminal by default, can toggle with keybind
            hide = { 'go', 'python' },
          },
        },
      },
    },

    -- Inline virtual text for variable values
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {
        virt_text_pos = 'eol', -- Display at end of line
        highlight_changed_variables = true,
        show_stop_reason = true,
      },
    },

    -- REPL syntax highlighting
    {
      'LiadOz/nvim-dap-repl-highlights',
      opts = {},
    },

    -- Python debugging
    {
      'mfussenegger/nvim-dap-python',
      ft = 'python',
      config = function()
        local dap_python = require('dap-python')
        -- Use debugpy installed by Mason
        dap_python.setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
        -- Use pytest as test runner
        dap_python.test_runner = 'pytest'
      end,
    },

    -- Go debugging
    {
      'leoluz/nvim-dap-go',
      ft = 'go',
      config = function()
        require('dap-go').setup({
          -- Use delve installed by Mason
          delve = {
            path = vim.fn.stdpath('data') .. '/mason/bin/dlv',
          },
        })
      end,
    },
  },

  keys = {
    -- Core debugging
    { '<leader>dc', function() require('dap').continue() end, desc = 'Debug: Continue' },
    { '<leader>do', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
    { '<leader>di', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
    { '<leader>du', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
    { '<leader>dl', function() require('dap').run_last() end, desc = 'Debug: Run Last' },
    { '<leader>dt', function() require('dap').terminate() end, desc = 'Debug: Terminate' },

    -- Breakpoints
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end,
      desc = 'Debug: Conditional Breakpoint',
    },
    {
      '<leader>dp',
      function()
        require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
      end,
      desc = 'Debug: Log Point',
    },

    -- UI
    { '<leader>dv', function() require('dap-view').toggle() end, desc = 'Debug: Toggle View' },
    { '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Debug: Toggle REPL' },

    -- Hover/eval
    { '<leader>dh', function() require('dap.ui.widgets').hover() end, desc = 'Debug: Hover', mode = { 'n', 'v' } },
    { '<leader>de', function() require('dap.ui.widgets').preview() end, desc = 'Debug: Preview/Eval' },
  },

  config = function()
    local dap = require('dap')
    local dap_view = require('dap-view')

    -- Load VS Code launch.json configurations
    require('dap.ext.vscode').load_launchjs(nil, {
      codelldb = { 'rust', 'c', 'cpp' },
    })

    -- Custom highlight groups for DAP signs
    vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#e51400' }) -- Red
    vim.api.nvim_set_hl(0, 'DapBreakpointCondition', { fg = '#f5a623' }) -- Orange
    vim.api.nvim_set_hl(0, 'DapLogPoint', { fg = '#61afef' }) -- Blue
    vim.api.nvim_set_hl(0, 'DapStopped', { fg = '#98c379' }) -- Green
    vim.api.nvim_set_hl(0, 'DapStoppedLine', { bg = '#2e4d2e' }) -- Dark green background
    vim.api.nvim_set_hl(0, 'DapBreakpointRejected', { fg = '#656565' }) -- Gray

    -- Redefine breakpoint signs AFTER nvim-dap loads (override its defaults)
    -- Must undefine first since sign_define won't override existing signs
    for _, name in ipairs({ 'DapBreakpoint', 'DapBreakpointCondition', 'DapLogPoint', 'DapStopped', 'DapBreakpointRejected' }) do
      vim.fn.sign_undefine(name)
    end
    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DapBreakpointCondition' })
    vim.fn.sign_define('DapLogPoint', { text = '◉', texthl = 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapStopped', linehl = 'DapStoppedLine' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '○', texthl = 'DapBreakpointRejected' })

    -- Auto-open DAP View when debugging starts
    dap.listeners.after.event_initialized['dap-view'] = function()
      dap_view.open()
    end

    -- Auto-close DAP View when debugging ends
    dap.listeners.before.event_terminated['dap-view'] = function()
      dap_view.close()
    end
    dap.listeners.before.event_exited['dap-view'] = function()
      dap_view.close()
    end
  end,
}
