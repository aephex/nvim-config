return {
  'Exafunction/codeium.vim',
  name = 'codeium',
  config = function()
    vim.g.codeium_enabled = false
    vim.g.codeium_no_map_tab = true
    vim.g.codeium_idle_delay = 250
  end
}
