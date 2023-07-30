return {
  'gennaro-tedesco/nvim-possession',
  dependencies = { 'ibhagwan/fzf-lua' },
  build = ':!mkdir -p ~/.local/share/nvim/sessions',
  config = function()
    require("nvim-possession").setup({
      autoload = true,
      autosave = true,
      sessions = {
        sessions_icon = " "
      }
    })
  end
}
