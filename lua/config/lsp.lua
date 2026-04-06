vim.lsp.config('gopls', {
  settings = {
    gopls = {
      buildFlags = { '-tags=integration' },
      -- buildFlags = { '-mod=readonly', '-tags=integration' },
      gofumpt = true,
    },
  },
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
