return {
  -- Fuzzy finder plus the thing that keeps me from losing all my hair
  'nvim-telescope/telescope.nvim',

  tag = '0.1.6',

  dependencies = {
    'nvim-lua/plenary.nvim'
  },

  config = function()
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
    vim.keymap.set('n', '<leader>f', builtin.git_files, {})
    vim.keymap.set('n', "<leader>ps", builtin.grep_string, {})
    vim.keymap.set('n', '<C-p>s', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    vim.keymap.set('n', '<C-p>o', builtin.oldfiles, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

    -- I use folds so this stops nvim from folding telescope results
    vim.api.nvim_create_autocmd("FileType", { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] })
  end
}
