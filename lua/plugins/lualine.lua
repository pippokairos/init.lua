return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'abeldekat/harpoonline' },
    opts = function()
      local harpoon_component
      local harpoonline_ok, Harpoonline = pcall(require, 'harpoonline')
      if harpoonline_ok then
        Harpoonline.setup()
        harpoon_component = Harpoonline.format
      else
        vim.notify('Harpoonline not found or failed to load for Lualine', vim.log.levels.WARN)
      end

      return {
        options = {
          icons_enabled = vim.g.have_nerd_font,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          globalstatus = false,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { harpoon_component, 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { 'nvim-tree', 'trouble' },
      }
    end,
  },
}
