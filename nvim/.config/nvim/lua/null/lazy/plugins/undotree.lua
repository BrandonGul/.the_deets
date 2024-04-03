return {
  -- For when you fucked up real bad
  'mbbill/undotree',

  config = function ()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
  end
}
