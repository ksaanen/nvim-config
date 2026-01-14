local treesitter = require("nvim-treesitter.config")
treesitter.setup({
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
	ignore_install = {},
	sync_install = true
})
