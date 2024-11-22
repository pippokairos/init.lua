return {
  {
    'rafi/awesome-vim-colorschemes',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      vim.cmd.colorscheme 'hybrid_reverse'

      -- Configure highlights
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
