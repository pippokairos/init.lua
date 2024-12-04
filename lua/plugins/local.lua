return {
  name = 'rspec-runner',
  dir = '~/private/rspec-runner.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  dev = true,
  init = function()
    local rspec_runner = require 'rspec-runner'

    vim.keymap.set('n', '<leader>rr', function()
      rspec_runner.run_file()
    end, { desc = '[R]un [R]Spec', noremap = false, silent = false })
  end,
}
