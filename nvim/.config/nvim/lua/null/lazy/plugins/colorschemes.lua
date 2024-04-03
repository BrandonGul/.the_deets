return {
  {
    'junegunn/seoul256.vim' ,
    as = 'seoul256',
    config = function()
      vim.g.seoul256_background = 235
    end
  },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require("rose-pine").setup({

        highlight_groups = {
            LineNrAbove = { fg = "foam" },
            LineNr = { fg = "text" },
            LineNrBelow = { fg = "love" },
            NonText = { fg = "base" }
        },

      })
      vim.cmd('colorscheme rose-pine-main')
    end
  }
}
