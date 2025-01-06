return {
  'github/copilot.vim', -- GitHub Copilot
  config = function()
    -- Disable by default
    vim.g.copilot_filetypes = {
      ['*'] = false,
    }

    -- Explicitly request for copilot suggestions on Ctrl-Enter
    vim.keymap.set('i', '<C-CR>', '<Plug>(copilot-suggest)')

    vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>', { desc = '[C]opilot [E]nable' })
    vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', { desc = '[C]opilot [D]isable' })
  end,
}
