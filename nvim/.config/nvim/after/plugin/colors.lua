function Colors(color)
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  vim.api.nvim_set_hl(0, "GitGutterAdd", { bg = "none", fg = "#009900"})
  vim.api.nvim_set_hl(0, "GitGutterChange", { bg = "none", fg = "#bbbb00" })
  vim.api.nvim_set_hl(0, "GitGutterDelete", { bg = "none", fg = "#ff2222" })
end

Colors()
