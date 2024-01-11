vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = { {'nvim-lua/plenary.nvim'} }
 }

  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
        require("rose-pine").setup()
        vim.cmd('colorscheme rose-pine-dawn')
    end
  })

  use({
    'junegunn/seoul256.vim' ,
    as = 'seoul256',
    config = function()
      vim.g.seoul256_background = 235
    end
  })

  use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use ('nvim-treesitter/playground')

  use ('ThePrimeagen/harpoon')

  use ('mbbill/undotree')
  use ('tpope/vim-fugitive')

  use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v1.x',
  requires = {
	    -- LSP Support
	    {'neovim/nvim-lspconfig'},             -- Required
	    {'williamboman/mason.nvim'},           -- Optional
	    {'williamboman/mason-lspconfig.nvim'}, -- Optional

	    -- Autocompletion
	    {'hrsh7th/nvim-cmp'},         -- Required
	    {'hrsh7th/cmp-nvim-lsp'},     -- Required
	    {'hrsh7th/cmp-buffer'},       -- Optional
	    {'hrsh7th/cmp-path'},         -- Optional
	    {'saadparwaiz1/cmp_luasnip'}, -- Optional
	    {'hrsh7th/cmp-nvim-lua'},     -- Optional

	    -- Snippets
	    {'L3MON4D3/LuaSnip'},             -- Required
	    {'rafamadriz/friendly-snippets'}, -- Optional
    }
  }

  use ('airblade/vim-gitgutter')
  use ({
    'christoomey/vim-tmux-navigator',
    config = function()
      vim.keymap.set('n', "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
      vim.keymap.set('n', "<C-j>", "<cmd>TmuxNavigateDown<CR>")
      vim.keymap.set('n', "<C-k>", "<cmd>TmuxNavigateUp<CR>")
      vim.keymap.set('n', "<C-l>", "<cmd>TmuxNavigateRight<CR>")
    end
    })

end)
