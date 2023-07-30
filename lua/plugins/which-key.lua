return {
  "folke/which-key.nvim",
  config = function()
    require('which-key').setup({
      window = { border = 'rounded' }
    })
  end
}
