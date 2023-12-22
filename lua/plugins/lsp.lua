return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
      },
      { "williamboman/mason-lspconfig.nvim" },
      {
        "neovim/nvim-lspconfig",
        dependencies = {
          {
            "hrsh7th/nvim-cmp",
            dependencies = {
              "hrsh7th/cmp-buffer",
              "hrsh7th/cmp-cmdline",
              "hrsh7th/cmp-nvim-lsp",
              "hrsh7th/cmp-nvim-lsp-signature-help",
              "hrsh7th/cmp-path",
              "L3MON4D3/LuaSnip",
              "rafamadriz/friendly-snippets",
              "ray-x/lsp_signature.nvim",
              "saadparwaiz1/cmp_luasnip",
              { "folke/neodev.nvim", opts = {} },
            },
          },
        },
      },
    },
    config = function()
      -- on_attach+keymaps defined in config/keymaps.lua
      local lsp = require("lsp-zero")
      local neo = require('neodev')
      local sig = require('lsp_signature')
      local utl = require('lspconfig.util')
      local cmp = require('cmp')
      local msn = require("mason")
      local lspcfgwin = require('lspconfig.ui.windows')
      local luasnip = require("luasnip")

      lsp.preset({
        name = 'recommended',
        set_lsp_keymaps = false,
      })

      local cmpcfg = cmp.get_config()
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup({
        mapping = {
          ["<CR>"] = cmp.mapping.confirm { select = false },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = vim.list_extend(cmpcfg.sources, {
          { name = 'nerdfont' },
        }, 1, #cmpcfg.sources),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        }
      })

      lspcfgwin.default_options.border = 'rounded'
      msn.setup({ ui = { border = 'rounded' } })

      lsp.setup_nvim_cmp({
        preselect = 'none',
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect'
        },
      })

      lsp.configure('lua_ls', {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
            telemetry = { enable = 'false' }
          }
        }
      })

      lsp.configure('docker_compose_language_service', {
        telemetry = { enable = 'false' },
        redhat = {
          telemetry = {
            enabled = false,
            enable = false
          }
        },
        filetypes = { 'yaml.docker-compose' },
        root_dir = utl.root_pattern { 'compose.yaml', 'docker-compose.yaml' },
      })

      lsp.configure('yamlls', {
        telemetry = { enable = 'false' },
        redhat = {
          telemetry = {
            enabled = false,
            enable = false
          }
        },
        settings = {
          yaml = {
            keyOrdering = false,
            customTags = {
              "!Ref sequence",
              "!reference sequence"
            }
          }
        }
      })

      lsp.configure('pylsp', {
        telemetry = { enable = 'false' },
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                maxLineLength = 160
              }
            }
          }
        }
      })

      lsp.configure('gopls', {
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true
          }
        }
      })

      lsp.set_preferences({
        sign_icons = {
          error = 'E',
          warn = 'W',
          hint = 'H',
          info = 'I'
        }
      })

      require("luasnip.loaders.from_vscode").lazy_load()

      lsp.setup()
      neo.setup()
      sig.setup({
        hint_enable = false
      })

      vim.diagnostic.config({
        virtual_text = true,
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    config = function()
      local nls = require('null-ls')

      nls.setup({
        sources = {
          nls.builtins.code_actions.shellcheck,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.markdownlint
        },
        border = 'rounded',
      })
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "nvim-lua/plenary.nvim"
    },
  },
}
