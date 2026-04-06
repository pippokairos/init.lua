-- The following must always be installed: "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline"
local languages = {
  'bash', 'c', 'diff', 'go', 'javascript', 'typescript', 'html', 'lua', 'luadoc', 'markdown',
  'markdown_inline', 'query', 'ruby', 'vim', 'vimdoc', 'json', 'yaml',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    opts = {
      ensure_installed = languages,
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  When experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      require('nvim-treesitter').setup(opts)
      vim.api.nvim_create_autocmd('FileType', {
        desc = 'Set up nvim-treesitter',
        pattern = languages,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
