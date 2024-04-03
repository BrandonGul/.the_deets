return {
  -- Adds git markers to gutter
  --     * Custom colors to match rose pine
  {
    'airblade/vim-gitgutter',
    config = function()
      vim.api.nvim_set_hl(0, "GitGutterAdd", { bg = "none", fg = "#009900"})
      vim.api.nvim_set_hl(0, "GitGutterChange", { bg = "none", fg = "#bbbb00" })
      vim.api.nvim_set_hl(0, "GitGutterDelete", { bg = "none", fg = "#ff2222" })
    end
  }
}
