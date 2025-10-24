vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("TS_add_missing_imports", { clear = true }),
	desc = "TS_add_missing_imports",
	pattern = { "*.ts" },
	callback = function()
		vim.lsp.buf.code_action({
			apply = true,
			context = {
				only = { "source.addMissingImports.ts", "source.organizeImports", "source.fixAll" },
			},
		})
		vim.cmd("write")
	end,
})
