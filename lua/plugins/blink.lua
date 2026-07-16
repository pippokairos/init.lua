return {
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    opts = {
      keymap = {
        preset = 'default',
        ['<Tab>'] = {
          'snippet_forward',
          function(_cmp)
            local ok, suggestion = pcall(require, 'copilot.suggestion')
            if not ok then return end
            if suggestion.is_visible() then
              suggestion.accept()
            else
              suggestion.next()
            end
            return true
          end,
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      signature = { enabled = true },
    },
  },
}
