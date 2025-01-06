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
    event = 'VeryLazy',
    opts = {
      enabled = false,
      message_template = ' <summary> • <date> • <author> • <<sha>>',
      date_format = '%m-%d-%Y %H:%M:%S',
      virtual_text_column = 1,
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
