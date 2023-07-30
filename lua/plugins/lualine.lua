return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    'arkav/lualine-lsp-progress'
  },
  config = function()
    local session = require('nvim-possession')

    require('lualine').setup {
      options = {
        theme = 'auto',
        globalstatus = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_b = { { 'filename', path = 2 } },
        lualine_c = { 'branch', 'diff' },
        lualine_x = {
          'lsp_progress',
          {
            function()
              return " " .. (vim.fn["codeium#GetStatusString"]():lower():gsub("^%l", string.upper))
            end,
          },
        },
        lualine_y = {
          'encoding',
          'fileformat',
          'filetype',
        },
        lualine_z = {
          {
            'location',
            padding = { left = 0, right = 1 },
          },
        }
      },
      tabline = {
        lualine_a = { 'buffers' },
        lualine_z = {
          {
            session.status,
            cond = function() return session.status ~= nil end,
          },
        }
      }
    }
  end
}
