local opt = vim.opt

-- Scrolling / Numbering
opt.relativenumber = true
opt.number = true
opt.scrolloff = 8

-- Indenting
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.smartindent = true
opt.softtabstop = 4
opt.tabstop = 4

-- FS / History
opt.backup = false
opt.backupcopy = 'yes'
opt.swapfile = false
opt.undofile = true
---@diagnostic disable-next-line: assign-type-mismatch
opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"

-- Search
opt.hlsearch = false
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true
opt.wrapscan = false

-- Timeouts
opt.timeout = true
opt.timeoutlen = 300

-- Completion Menu
opt.completeopt = 'menu,menuone,noinsert,noselect'

-- Layout
opt.splitright = true
opt.cmdheight = 1

-- Language
opt.spelllang = 'en_ca'

-- Look & Feel
opt.termguicolors = true -- 24bit colours
opt.background = 'dark'
