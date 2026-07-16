vim.lsp.config('gopls', {
  settings = {
    gopls = {
      buildFlags = { '-tags=integration' },
      -- buildFlags = { '-mod=readonly', '-tags=integration' },
      gofumpt = true,
    },
  },
})

vim.lsp.config("ruby_lsp", {
  on_attach = function(client, _)
    -- Disable Ruby-lsp's semantic tokens to avoid noisy
    -- race condition between ruby-lsp and Neovim's LSP client
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

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
