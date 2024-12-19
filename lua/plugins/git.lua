return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      vim.keymap.set('n', '<leader>gg', ':Neogit<CR>', { desc = 'Neo[G]it' })
      vim.keymap.set('n', '<leader>gl', ':Neogit log<CR>', { desc = 'Neo[G]it [L]og' })
      vim.keymap.set('n', '<leader>gd', ':DiffviewOpen<CR>', { desc = '[G]it [D]iffview open' })
      vim.keymap.set('n', '<leader>gc', ':DiffviewClose<CR>', { desc = '[G]it [D]iffview close' })
      vim.keymap.set('n', '<leader>gD', ':DiffviewOpen master<CR>', { desc = '[G]it [D]iffview open master' })
    end,
  },

  {
    'f-person/git-blame.nvim',
    -- load the plugin at startup
    event = 'VeryLazy',
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin wil only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = 'VeryLazy',
    -- or lazy = false. One of both options will work.
    opts = {
      -- your configuration comes here
      -- for example
      enabled = true, -- if you want to enable the plugin
      message_template = ' <summary> • <date> • <author> • <<sha>>', -- template for the blame message, check the Message template section for more options
      date_format = '%m-%d-%Y %H:%M:%S', -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
    },
  },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
}
