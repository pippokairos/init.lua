-- matchit decides which keywords to ignore by asking synID(), and Ruby's
-- ftplugin relies on that to skip `end` inside strings/comments and `if` used as
-- a statement modifier. Treesitter highlighting turns 'syntax' off, so synID()
-- returns nothing, the def/end nesting never balances and % silently fails to
-- find a method's `end`. Keep the syntax engine loaded; treesitter still wins
-- for highlighting. Deferred because treesitter attaches after this ftplugin.
local buf = vim.api.nvim_get_current_buf()
vim.schedule(function()
  if vim.api.nvim_buf_is_valid(buf) then
    vim.bo[buf].syntax = 'ON'
  end
end)
