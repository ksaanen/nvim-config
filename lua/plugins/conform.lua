-- Autoformat
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

local conform = require("conform")

vim.keymap.set("n", "<leader>fb", function()
	format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })

conform.setup({
	notify_on_error = false,
	format_on_save = {
		exclude_filetypes = { "c", "cpp" },
		timeout_ms = 500,
		lsp_format_opts = {
			-- 'fallback' will use Conform when no LSP client supports formatting.
			-- 'force' will always use Conform, ignoring LSP clients.
			-- 'auto' will use Conform if there is only one active formatter.
			-- You can also specify a list of client names to prefer over Conform.
			format = "fallback",
			-- Whether to format if the buffer was modified after formatting started
			allow_modifications = false,
		},
		quiet = true,
	},
	formatters_by_ft = {
		htmlangular = { "prettier" },
		lua = { "stylua" },
		markdown = { "prettier" },
		html = { "prettier" },
		javascript = { "prettier" },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettier" },
		scss = { "prettier" },
		json = { "prettier" },
		-- You can use 'stop_after_first' to run the first available formatter from the list
		-- javascript = { "prettierd", "prettier", stop_after_first = true },
	},
	cmd = { "ConformInfo" },
})
