return {
  {
    'ThePrimeagen/harpoon', -- A navigation and bookmarking plugin for Neovim
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()

      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local finder = function()
          local paths = {}
          for _, item in ipairs(harpoon_files.items) do
            table.insert(paths, item.value)
          end

          return require('telescope.finders').new_table {
            results = paths,
          }
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = finder(),
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
            attach_mappings = function(prompt_buffer_number, map)
              map('i', '<C-d>', function()
                local action_state = require 'telescope.actions.state'
                local selected_entry = action_state.get_selected_entry()
                local current_picker = action_state.get_current_picker(prompt_buffer_number)

                table.remove(harpoon_files.items, selected_entry.index)
                current_picker:refresh(finder())
              end)

              return true
            end,
          })
          :find()
      end

      vim.keymap.set('n', '<leader>h', function()
        toggle_telescope(harpoon:list())
      end, { desc = '[H]arpoon list' })

      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end, { desc = 'Harpoon [A]dd' })

      vim.keymap.set('n', '<C-h>', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon select 1' })

      vim.keymap.set('n', '<C-j>', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon select 2' })

      vim.keymap.set('n', '<C-k>', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon select 3' })

      vim.keymap.set('n', '<C-l>', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon select 4' })
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'abeldekat/harpoonline', version = '*' },
    config = function()
      local Harpoonline = require 'harpoonline'
      Harpoonline.setup {
        on_update = function()
          require('lualine').refresh()
        end,
      }

      local lualine_c = { Harpoonline.format, 'filename' }
      require('lualine').setup { sections = { lualine_c = lualine_c } }
    end,
  },
}
