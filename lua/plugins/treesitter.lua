-- The following must always be installed: "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline"
local languages = {
  'bash', 'c', 'diff', 'go', 'javascript', 'typescript', 'html', 'lua', 'luadoc',
  'markdown', 'markdown_inline', 'query', 'ruby', 'vim', 'vimdoc', 'json', 'yaml',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install(languages)

      vim.api.nvim_create_autocmd('FileType', {
        desc = 'Enable treesitter highlighting when a parser exists',
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
