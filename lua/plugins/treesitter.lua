local treesitter = require("nvim-treesitter")
treesitter.setup({
	configs = {
		build = ":TSUpdate",
		ensure_installed = {
			"lua",
			"typescript",
			"angular",
			"json",
			"html",
			"scss",
			"rust",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	},
})
