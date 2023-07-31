return {
  'nvim-telescope/telescope.nvim',
  version = '0.1.2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'ahmedkhalf/project.nvim',
    'cljoly/telescope-repo.nvim',
    'nvim-telescope/telescope-file-browser.nvim',
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local ts = require('telescope')
    local projects = require('project_nvim')

    projects.setup {
      exclude_dirs = {
        '~/',
        '~/projects',
        '~/.config/nvim/lua/*',
        '~/*/vendor/*',
      },
      patterns = {
        '.git',
        'init.lua',
        '.envrc',
        '.project_root'
      },
      detection_methods = { 'pattern', 'lsp' }
    }

    ts.setup {
      extensions = {
        file_browser = {
          hijack_netrw = true
        },
        repo = {
          list = {
            fd_opts = {
              "--no-ignore-vcs",
            },
            search_dirs = {
              "~/projects",
              "~/nexus",
              "~/.local"
            }
          }
        }
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }
        }
      }
    }

    local enabled_extensions = {
      'file_browser',
      'projects',
      'repo',
      'fzf'
    }

    for _, extension in pairs(enabled_extensions) do
      ts.load_extension(extension)
    end
  end
}
