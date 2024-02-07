local lsp       = require("lsp-zero")
local sessions  = require('nvim-possession')
local telescope = require('telescope')
local tsbuiltin = require('telescope.builtin')
local cmd       = vim.cmd
local map       = vim.keymap.set

-- vim.g.mapleader set in lua/config/init.lua

-- Buffers
map("n", "<C-PageUp>", cmd.bprevious, { desc = 'Previous buffer' })
map("n", "<C-PageDown>", cmd.bnext, { desc = 'Next buffer' })

-- Clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = 'Yank selection to system' })
map("n", "<leader>Y", [["+Y]], { desc = 'Yank line to system' })
map("x", "<leader>p", [["_dP]], { desc = 'keep clipboard when pasting' })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = 'keep clipboard when deleting' })

-- Commands
map("n", "gX", "yiW:!google-chrome-stable <cfile><CR>", { desc = 'Open URL with Chrome' }) -- gx without <leader> will use default browser
map("n", "<leader>q", cmd.bdelete, { desc = 'Close current buffer' })
map("n", "<leader>Q", ":bdelete!<CR>", { desc = 'Force close current buffer' })
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = 'Make current file executable' })
map("n", "<F3>", cmd.E, { desc = 'Open Explorer (NetRW)' })
-- map("n", "<F3>", telescope.extensions.file_browser.file_browser, { desc = 'Open Explorer (Telescope)' })
map('n', '<leader>cc', ':ColorizerToggle<CR>', { desc = '[c]olor [c]odes toggle' })

-- Codeium
map('n', '<leader>ae', ':Codeium Enable<CR>', { desc = '[a]i [e]nable' })
map('n', '<leader>ad', ':Codeium Disable<CR>', { desc = '[a]i [d]isable' })
map('i', '<M-a>', function() return vim.fn['codeium#Accept']() end, { desc = 'Accept Codeium Completion', expr = true })
map('i', '<M-x>', function() return vim.fn['codeium#Clear']() end, { desc = 'Clear Codeium Completion', expr = true })
-- Default: <M-[> Previous Completion
-- Default: <M-]> Next Completion

-- Moving
map("n", "<C-d>", "<C-d>zz", { desc = 'Half page down, keep view centered' })
map("n", "<C-u>", "<C-u>zz", { desc = 'Half page up, keep view centered' })
map("n", "n", "nzzzv", { desc = 'Next result, keep view centered' })
map("n", "N", "Nzzzv", { desc = 'Previous result, keep view centered' })

-- Move Selections
map("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Notes / KB / Wiki / Todo
-- All assume you are in the correct CWD.
-- Use Telescope/Projects keybinds below to ensure this
-- or set it with something like `:cd %:h` from an existing note.
-- It will replace everything except the first line and then try to format ('cause useless titles).
map('n', '<leader>gn', ":find index.md<CR><ESC>", { desc = '[g]o to [n]otes index' })
map('n', '<leader>nn', ":tabe .md | silent !mkdir -p %:p:h<C-b><C-Right><Right>", { desc = '[n]ew [n]ote' })
map('n', '<leader>ni', "gg\"zddVGdi<C-r>=map(glob('**/*', 0, 1), 'join([\"-\", v:val])')<CR><ESC>gg\"zP:lua vim.lsp.buf.format()<CR>",
  { desc = 'generate [n]otes [i]ndex inline' })

-- Quality of Life
map("i", "<C-c>", "<Esc>")
map("n", "Q", "<nop>") -- disable shift+q

-- Search & Replace
map("n", "<C-h>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace occurences of word' })
map("v", "<C-h>", [[y<ESC>:%s@\V<C-r>0@@gI<Left><Left><Left>]], { desc = 'Replace occurences selection' })

-- Sessions
map('n', '<leader>sn', function() sessions.new() end, { desc = '[s]ession [n]ew' })
map('n', '<leader>sl', function() sessions.list() end, { desc = '[s]ession [l]ist' })
map('n', '<leader>su', function() sessions.update() end, { desc = '[s]ession [u]pdate' })

-- Telescope
map('n', '<leader>so', tsbuiltin.buffers, { desc = '[s]earch [o]pen buffers' })
map('n', '<leader>sf', tsbuiltin.find_files, { desc = '[s]earch [f]iles' })
map('n', '<leader>sc', tsbuiltin.git_files, { desc = '[s]earch [c]ommitted files' })
map('n', '<leader>sw', tsbuiltin.grep_string, { desc = '[s]earch current [w]ord' })
map('n', '<leader>sg', tsbuiltin.live_grep, { desc = '[s]earch with [g]rep' })
map('n', '<leader>sp', telescope.extensions.projects.projects, { desc = '[s]earch [p]rojects' })
map('n', '<leader>sh', tsbuiltin.help_tags, { desc = '[s]eek [h]elp' })
map("n", "<leader>th", tsbuiltin.highlights, { desc = '[t]elescope [h]ighlights' })

-- Only active when LSP client is attached
lsp.on_attach(function(_, bufnr)
  local default_options = { buffer = bufnr, remap = false }

  local function opts(options)
    if options == nil then return default_options end

    for option, default in pairs(default_options) do
      if options[option] == nil then
        options[option] = default
      end
    end

    return options
  end

  local function smart_definition()
    if tsbuiltin.lsp_definitions() then
      return
    end

    if vim.lsp.buf.definition() then
      return
    end

    if cmd(':tag ' .. vim.fn.expand('<cword>')) then
      return
    end
  end

  map("n", "<leader>f", vim.lsp.buf.format, { desc = 'Format buffer using LSP' })

  map("n", "<leader>va", tsbuiltin.diagnostics, opts({ desc = '[v]iew [a]ll diagnostics' }))
  map("n", "<leader>vs", vim.lsp.buf.hover, opts({ desc = '[v]iew [s]ource' }))
  map("n", "<leader>vd", vim.diagnostic.open_float, opts({ desc = '[v]iew [d]iagnostics' }))
  map("n", "<leader>ca", vim.lsp.buf.code_action, opts({ desc = '[c]ode [a]ction' })) -- also <F4>

  map("n", "K", vim.lsp.buf.hover, opts({ desc = 'displays symbol info in hover' }))
  map("n", "<C-k>", vim.lsp.buf.signature_help, opts({ desc = 'Signature Help' }))
  map("i", "<C-k>", vim.lsp.buf.signature_help, opts({ desc = 'Signature Help', remap = 'true' }))

  map("n", "gd", function() pcall(smart_definition) end, opts({ desc = '[g]o to [d]efinition' }))
  map("n", "gD", vim.lsp.buf.declaration, opts({ desc = '[g]o to [D]eclaration' }))
  map("n", "gi", tsbuiltin.lsp_implementations, opts({ desc = '[g]o to [i]mplementation' }))
  map("n", "gt", tsbuiltin.lsp_type_definitions, opts({ desc = '[g]o to [t]ype definition' }))

  map("n", "<leader>sr", tsbuiltin.lsp_references, opts({ desc = '[s]earch [r]eferences' }))
  map("n", "<leader>ss", tsbuiltin.lsp_dynamic_workspace_symbols, opts({ desc = '[s]earch [s]ymbols' }))
  map("n", "<leader>sb", tsbuiltin.lsp_document_symbols, opts({ desc = '[s]earch [b]uffer symbols' }))
end)
