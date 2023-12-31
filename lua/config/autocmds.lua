local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- resize splits if window got resized
autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Stop commenting code from creating indents regardless of filetype
autocmd("FileType", {
  pattern = "",
  command = "setlocal indentkeys-=0#"
})

-- Don't auto comment new lines
autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o"
})

-- Auto-enable spelling for text files
autocmd("Filetype", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end
})

-- Make active window more visible
autocmd("WinEnter", {
  pattern = "",
  callback = function()
    vim.opt_local.relativenumber = true
    vim.opt_local.cursorline = true
  end
})
autocmd("WinLeave", {
  pattern = "",
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
  end
})
