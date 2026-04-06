return {
  {
    -- `lazydev` configures Lua LSP for the Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  { 'Bilal2453/luvit-meta', lazy = true },
  { 'neovim/nvim-lspconfig' },
  { 'mason-org/mason.nvim', opts = {} },
  {
    'mason-org/mason-lspconfig.nvim',
    -- event = 'BufReadPost',
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      ensure_installed = {
        'html',
        'gopls',
        'jsonls',
        'lua_ls',
        'pylsp',
        'ruby_lsp',
      },
      automatic_installation = true,
    },
  },

}
