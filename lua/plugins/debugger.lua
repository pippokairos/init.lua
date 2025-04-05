return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'leoluz/nvim-dap-go',
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },

    config = function()
      require('mason-nvim-dap').setup {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          'delve',
        },
      }

      local dap, dapui = require 'dap', require 'dapui'
      require('dapui').setup()
      require('dap-go').setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, { desc = '[D]ebugger Add [B]reakpoint' })
      vim.keymap.set('n', '<Leader>dC', dap.clear_breakpoints, { desc = '[D]ebugger [C]lear breakpoints' })
      vim.keymap.set('n', '<Leader>dr', "<cmd>lua require('dapui').open({reset = true})<CR>", { desc = '[D]ebugger [R]eset UI' })

      -- Standard DAP Controls
      vim.keymap.set('n', '<Leader>dc', dap.continue, { desc = '[D]ebugger [C]ontinue' })
      vim.keymap.set('n', '<Leader>dso', dap.step_over, { desc = '[D]ebugger Step [O]ver' })
      vim.keymap.set('n', '<Leader>dsi', dap.step_into, { desc = '[D]ebugger Step [I]nto' })
      vim.keymap.set('n', '<Leader>dsu', dap.step_out, { desc = '[D]ebugger Step O[u]t' })

      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debugger: Continue (F5)' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debugger: Step Over (F10)' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debugger: Step Into (F11)' })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debugger: Step Out (F12)' })

      -- Test debugging
      vim.keymap.set('n', '<Leader>dt', function()
        require('dap-go').debug_test()
      end, { desc = '[D]ebugger Go [T]est Function' })

      vim.keymap.set('n', '<Leader>dl', function()
        require('dap-go').debug_last_test()
      end, { desc = '[D]ebugger Go [L]ast Test' })
    end,
  },
}
