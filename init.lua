-- Packages
-- -----------------------------------------------------------------------------

if vim.pack == nil then
	local function bootstrap_pckr()
	local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

	if not (vim.uv or vim.loop).fs_stat(pckr_path) then
		vim.fn.system({
		'git',
		'clone',
		"--filter=blob:none",
		'https://github.com/lewis6991/pckr.nvim',
		pckr_path
		})
	end

	vim.opt.rtp:prepend(pckr_path)
	end

	bootstrap_pckr()

	require('pckr').add{
		"neovim/nvim-lspconfig",
		"nvim-tree/nvim-web-devicons",
		"folke/which-key.nvim",
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		{ "nvim-telescope/telescope.nvim", branch = "0.1.x" },
		{ "folke/tokyonight.nvim", name = "tokyonight" },
		"echasnovski/mini.nvim",
		"nvim-treesitter/nvim-treesitter",
		"chentoast/marks.nvim",
		"github/copilot.vim"
	}
else
	vim.pack.add({
		-- nvim-lspconfig
		{ src = 'https://github.com/neovim/nvim-lspconfig' },

		-- Devicons
		{ src = "https://github.com/nvim-tree/nvim-web-devicons" },

		-- Which-key / keymap information
		{ src = "https://github.com/folke/which-key.nvim" },

		-- Telescope
		{ src = "https://github.com/nvim-lua/plenary.nvim" },
		{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		{ src = "https://github.com/nvim-telescope/telescope.nvim",            branch = "0.1.x" },

		-- Tokyonight colorscheme
		{ src = "https://github.com/folke/tokyonight.nvim",                    name = "tokyonight" },

		-- Mini / statusline
		{ src = "https://github.com/echasnovski/mini.nvim" },

		-- Treesitter / fileparsers
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },

		-- Marks
		{ src = "https://github.com/chentoast/marks.nvim" },

		-- Copilot
		{ src = "https://github.com/github/copilot.vim" },
	})
end



-- Init tokyonight color scheme
vim.cmd.colorscheme("tokyonight-moon")

-- Load plugin configurations
require("plugins.which-key")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.mini")
require("plugins.marks")

-- General Settings
-- -----------------------------------------------------------------------------
require("core.lsp")
require("core.globals")
require("core.options")
require("core.keymap")
require("core.autocmds")
