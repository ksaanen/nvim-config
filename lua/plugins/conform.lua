require("conform").setup({
	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
        formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "biome", "biome-organize-imports" },
            javascriptreact = { "biome", "biome-organize-imports" }, 
            typescript = { "biome", "biome-organize-imports" },
            typescriptreact = { "biome", "biome-organize-imports" },
            rust = { "rustfmt" },
        },
	formatters = {
		biome = { require_cwd = true },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},	
})
