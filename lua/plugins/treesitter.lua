local treesitter = require("nvim-treesitter")
treesitter.setup({
	configs = {

		build = ":TSUpdate",
		ensure_installed = {
			"lua",
			"rust",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	},
})
