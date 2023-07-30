local opt = vim.opt

-- Scrolling / Numbering
opt.relativenumber = true
opt.number = true
opt.scrolloff = 8

-- Indenting
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 2
opt.smartindent = true
opt.softtabstop = 2
opt.tabstop = 2

-- FS / History
opt.backup = false
opt.backupcopy = 'yes'
opt.swapfile = false
opt.undofile = true
---@diagnostic disable-next-line: assign-type-mismatch
opt.undodir = os.getenv('HOME') .. '/.local/share/nvim/undodir'

-- Search
opt.hlsearch = false
opt.ignorecase = true
opt.incsearch = true
opt.smartcase = true
opt.wrapscan = false

-- Timeouts
opt.timeout = true
opt.timeoutlen = 300

-- Completions
opt.completeopt = 'menu,menuone,noinsert,noselect'
opt.wildmode = 'longest:full,full'

-- Layout
opt.splitbelow = true
opt.splitright = true
opt.cmdheight = 1

-- Language
opt.spelllang = { 'en', 'en_ca' }

-- Look & Feel
opt.termguicolors = true -- 24bit colours
opt.background = 'dark'
opt.list = true
opt.cursorline = true

-- Disable Mouse
opt.mouse = nil
