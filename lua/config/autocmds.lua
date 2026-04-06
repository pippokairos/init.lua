-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Autoimport and format Go files on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    -- Use synchronous request for organize imports to ensure it completes before format
    local params = vim.lsp.util.make_range_params(0, 'utf-8')
    params.context = { only = { 'source.organizeImports' } }

    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 200)
    if result then
      for _, res in pairs(result) do
        if res.result then
          for _, action in pairs(res.result) do
            if action.edit then
              vim.lsp.util.apply_workspace_edit(action.edit, 'utf-8')
            end
          end
        end
      end
    end

    -- Then format
    vim.lsp.buf.format({ async = false })
  end,
})

-- Rename
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = ev.buf })
  end,
})
