-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = '[D]iagnostic [O]pen float' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', 'Z<CR>', '<cmd>update<CR>', { desc = 'Save file' })

vim.keymap.set('n', '<leader>cp', function()
  vim.fn.setreg('+', vim.fn.expand '%:p')
  vim.notify 'File path copied to clipboard'
end, { desc = 'Copy [P]ath to clipboard' })

vim.keymap.set('n', '<leader>ob', '<cmd>!open -a "Google Chrome" "%"<cr>', { desc = '[O]pen the current file in [B]rowser' })

-- Move while in insert mode
vim.keymap.set('i', '<C-j>', '<Down>', { desc = 'Move down' })
vim.keymap.set('i', '<C-k>', '<Up>', { desc = 'Move up' })
vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Move left' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Move right' })

-- Preserve clipboard
vim.keymap.set('x', '<leader>p', [["_dP]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')

-- Search and replace word
vim.keymap.set('n', '<leader>sar', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Run PlenaryTestFile on the current buffer
vim.keymap.set('n', '<leader>tf', '<Plug>PlenaryTestFile', { desc = 'Plenary [T]est [F]ile', noremap = false, silent = false })

-- Go

-- Run current go file
vim.keymap.set('n', '<leader>rg', '<cmd>:!go run %<CR>', { desc = '[R]un [G]o file' })

-- Run current go test folder file
vim.keymap.set('n', '<leader>rt', function()
  local file_path = vim.fn.expand '%'
  local folder_path = vim.fn.fnamemodify(file_path, ':h')
  vim.cmd('!go test ./' .. folder_path)
end, { desc = '[R]un Go [T]ests' })
