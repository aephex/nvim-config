return {
  "folke/tokyonight.nvim",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      --- @usage storm, moon, night, day
      style = "moon",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    }

    vim.cmd.colorscheme('tokyonight')
  end
}
