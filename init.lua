-- Packages
-- -----------------------------------------------------------------------------
vim.pack.add({

	-- Devicons
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },

	-- Which-key
	{ src = "https://github.com/folke/which-key.nvim" },

	-- Telescope
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", branch = "0.1.x" },

	-- Catppucchin
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },

	-- Blink
	{ src = "saghen/blink.nvim" },

	-- Cmp
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
	{ src = "https://github.com/hrsh7th/cmp-buffer" },
	{ src = "https://github.com/hrsh7th/cmp-path" },
	{ src = "https://github.com/hrsh7th/cmp-cmdline" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },

	-- Conform
	{ src = "https://github.com/stevearc/conform.nvim" },

	-- Mini
	{ src = "https://github.com/echasnovski/mini.nvim" },

	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },

	-- Copilot
	{ src = "https://github.com/github/copilot.vim" },
})

-- Init catpuccin color scheme
vim.cmd.colorscheme("catppuccin")

-- Init statusline
require("mini.statusline").setup()

-- Load plugin configurations
require("plugins.which-key")
require("plugins.cmp")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.conform")
require("plugins.blink")

-- General Settings
-- -----------------------------------------------------------------------------
require("config.lsp")
require("config.globals")
require("config.options")
require("config.keymap")
