-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a simpler shortcut than <C-\><C-n>
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Save file
vim.keymap.set('n', 'Z<CR>', '<cmd>update<CR>', { desc = 'Save file' })

-- Copy current file path to clipboard and show a message
vim.keymap.set('n', '<leader>cp', function()
  vim.fn.setreg('+', vim.fn.expand '%:p')
  vim.notify 'File path copied to clipboard'
end, { desc = 'Copy [P]ath to clipboard' })

-- Open in browser
vim.keymap.set('n', '<leader>ob', '<cmd>!open -a "Google Chrome" "%"<cr>', { desc = '[O]pen the current file in [B]rowser' })

-- Move while in insert mode
vim.keymap.set('i', '<C-j>', '<Down>', { desc = 'Move down' })
vim.keymap.set('i', '<C-k>', '<Up>', { desc = 'Move up' })
vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Move left' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'Move right' })

-- Scolling with centered view
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Centered search results
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- Preserve clipboard
vim.keymap.set('x', '<leader>p', [["_dP]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')

-- Search and replace word
vim.keymap.set('n', '<leader>sar', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Run PlenaryTestFile on the current buffer
vim.keymap.set('n', '<leader>tf', '<Plug>PlenaryTestFile', { desc = 'Plenary [T]est [F]ile', noremap = false, silent = false })

-- Run current go file
vim.keymap.set('n', '<leader>rg', '<cmd>:!go run %<CR>', { desc = '[R]un [G]o file' })
