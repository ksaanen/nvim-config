-- Packages
-- -----------------------------------------------------------------------------
vim.pack.add({
	-- nvim-lspconfig
	{ src = 'https://github.com/neovim/nvim-lspconfig' },

	-- Devicons
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },

	-- Which-key / keymap information
	{ src = "https://github.com/folke/which-key.nvim" },

	-- Telescope
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim",  branch = "0.1.x" },

	-- Catppucchin colorscheme
	-- { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },

	-- Tokyonight colorscheme
	{ src = "https://github.com/folke/tokyonight.nvim",          name = "tokyonight" },

	-- Blink / blinktree
	{ src = "https://github.com/saghen/blink.nvim" },

	-- Mini / statusline
	{ src = "https://github.com/echasnovski/mini.nvim" },

	-- Treesitter / fileparsers
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },

	-- Copilot
	{ src = "https://github.com/github/copilot.vim" },
})

-- Init catpuccin color scheme
-- vim.cmd.colorscheme("catppuccin")

-- Init tokyonight color scheme
vim.cmd.colorscheme("tokyonight-moon")

-- Load plugin configurations
require("plugins.which-key")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.blink")
require("plugins.mini")

-- General Settings
-- -----------------------------------------------------------------------------
require("core.lsp")
require("core.globals")
require("core.options")
require("core.keymap")
