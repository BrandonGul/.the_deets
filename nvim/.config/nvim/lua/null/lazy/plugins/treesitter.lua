return {
  -- Better colors, better nvim, jappa pohns.
  {
    'nvim-treesitter/nvim-treesitter',

    build = ':TSUpdate',

    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {  "lua", "vimdoc", "php", "yaml", "vue", "javascript", "typescript",  "html", "scss", "css"},

        sync_install = false,

        auto_install = false,

        ignore_install = { },

        indent = {
          enable = true,
        },

        highlight = {
          enable = true,
          disable = { },
          additional_vim_regex_highlighting = false,
        },
      }
    end
  },
}
