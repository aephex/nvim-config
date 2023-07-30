local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = "\\"

require("lazy").setup({
  spec = { { import = "plugins" } },
  defaults = {
    lazy = false,
    version = nil
    -- version = "*", -- enable this to try installing the latest stable versions of plugins
  },
  install = {
    missing = true,
    colorscheme = { 'tokyonight' }
  },
  checker = {
    enabled = true,
    notify = false,
    frequency = 86400
  },
  change_detection = {
    enabled = true,
    notify = false
  },
})

local modules = {
  "config.autocmds",
  "config.keymaps",
  "config.options",
}

for _, mod in ipairs(modules) do
  local ok, err = pcall(require, mod)
  if not ok then
    error(("Error loading %s...\n\n%s"):format(mod, err))
  end
end
