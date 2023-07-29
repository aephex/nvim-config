---@diagnostic disable-next-line: unused-local
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Stop commenting code from creating indents regardless of filetype
autocmd("FileType", {
  command = "setlocal indentkeys-=0#"
})

-- Don't auto comment new lines
autocmd("BufEnter", {
    pattern = "",
    command = "set fo-=c fo-=r fo-=o"
})

autocmd("Filetype", {
    pattern = {"gitcommit", "markdown", "text"},
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end
})
