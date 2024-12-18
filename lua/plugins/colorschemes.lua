return {
  {
    'rafi/awesome-vim-colorschemes',
    -- priority = 1000,
    -- init = function()
    --   vim.cmd.colorscheme 'hybrid_reverse'
    --   vim.cmd.hi 'Comment gui=none'
    -- end,
  },

  { 'folke/tokyonight.nvim' },
  { 'rose-pine/neovim' },
  {
    'catppuccin/nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
    config = function()
      require('catppuccin').setup {
        no_italic = true,
      }
    end,
  },
}
