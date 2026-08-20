vim.lsp.config('gopls', {
  settings = {
    gopls = {
      buildFlags = { '-tags=integration' },
      -- buildFlags = { '-mod=readonly', '-tags=integration' },
      gofumpt = true,
    },
  },
})

vim.lsp.config('ruby_lsp', {
  cmd = { 'ruby-lsp' },
  on_attach = function(client, _)
    -- Treesitter owns highlighting; ruby-lsp semantic tokens fight it.
    client.server_capabilities.semanticTokensProvider = nil
  end,
})
-- Not installed via Mason (ABI-bound gems); enable explicitly so it attaches.
vim.lsp.enable 'ruby_lsp'

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      workspace = {
        checkThirdParty = false,
        telemetry = { enable = false },
        library = {
          "${3rd}/love2d/library"
        }
      },
    },
  },
})
