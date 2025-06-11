return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
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

  -- {
  --   -- Main LSP Configuration
  --   'neovim/nvim-lspconfig',
  --   dependencies = {
  --     -- Automatically install LSPs and related tools to stdpath for Neovim
  --     { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
  --     'williamboman/mason-lspconfig.nvim',
  --     'WhoIsSethDaniel/mason-tool-installer.nvim',
  --
  --     -- Useful status updates for LSP.
  --     -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
  --     { 'j-hui/fidget.nvim', opts = {} },
  --     'saghen/blink.cmp',
  --   },
  --   config = function()
  --     local capabilities = require('blink.cmp').get_lsp_capabilities()
  --     require('lspconfig').lua_ls.setup { capabilities = capabilities }
  --     local servers = {
  --       html = {},
  --       gopls = {
  --         settings = {
  --           gopls = {
  --             analyses = {
  --               unusedparams = true,
  --             },
  --             staticcheck = true,
  --             buildFlags = { '-tags=integration' },
  --             directoryFilters = { '-node_modules' },
  --             expandWorkspaceToModule = true,
  --           },
  --         },
  --       },
  --       pyright = {},
  --       ruby_lsp = {},
  --       lua_ls = {
  --         -- cmd = {...},
  --         -- filetypes = { ...},
  --         -- capabilities = {},
  --         settings = {
  --           Lua = {
  --             completion = {
  --               callSnippet = 'Replace',
  --             },
  --             runtime = {
  --               version = 'LuaJIT',
  --             },
  --             workspace = {
  --               library = vim.api.nvim_get_runtime_file('lua', true),
  --             },
  --             -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
  --             -- diagnostics = { disable = { 'missing-fields' } },
  --           },
  --         },
  --       },
  --     }
  --
  --     -- Ensure the servers and tools above are installed
  --     --  To check the current status of installed tools and/or manually install
  --     --  other tools, you can run
  --     --    :Mason
  --     --
  --     --  You can press `g?` for help in this menu.
  --     require('mason').setup()
  --
  --     local ensure_installed = vim.tbl_keys(servers or {})
  --     -- You can add other tools here that you want Mason to install
  --     -- for you, so that they are available from within Neovim.
  --     -- vim.list_extend(ensure_installed, {
  --     --   'stylua', -- Used to format Lua code
  --     -- })
  --     -- require('mason-tool-installer').setup { ensure_installed = ensure_installed }
  --
  --     require('mason-lspconfig').setup {
  --       handlers = {
  --         function(server_name)
  --           local server = servers[server_name] or {}
  --           -- This handles overriding only values explicitly passed
  --           -- by the server configuration above. Useful when disabling
  --           -- certain features of an LSP (for example, turning off formatting for ts_ls)
  --           server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
  --           require('lspconfig')[server_name].setup(server)
  --         end,
  --       },
  --       automatic_enable = true,
  --       ensure_installed = ensure_installed,
  --     }
  --   end,
  -- },

  -- New setup
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
        'lua_ls',
        'pylsp',
        'ruby_lsp',
      },
      automatic_installation = true,
    },
  },

  vim.lsp.config('gopls', {
    settings = {
      gopls = {
        buildFlags = { '-tags=integration' },
      },
    },
  }),

  -- Autoimport and format Go files on save
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.go',
    callback = function()
      local params = vim.lsp.util.make_range_params(0, 'utf-8')
      params.context = { only = { 'source.organizeImports' }, diagnostics = {} }

      vim.lsp.buf.format { async = false }
      vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, result, _, _)
        if err or not result or vim.tbl_isempty(result) then
          return -- Do nothing if there are no code actions available
        end
        vim.lsp.buf.code_action {
          context = { only = { 'source.organizeImports' }, diagnostics = {} },
          apply = true,
        }
      end)
    end,
  }),

  -- Rename
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function()
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
    end,
  }),
}
