--[[
--
-- Add code actions in quickfix list upon saving *.ts files
--
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
--]]

-- Lsp 
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/implementation') then vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "[G]o to [I]mplementation" }) end
		if client:supports_method('textDocument/definition') then vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinition" }) end
		if client:supports_method('textDocument/declaration') then vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]o to [D]eclaration" }) end
		if client:supports_method('textDocument/references') then vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "[G]o to [R]eferences" }) end
		if client:supports_method('textDocument/hover') then vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" }) end
		if client:supports_method('textDocument/codeAction') then vim.keymap.set("n", "<A-CR>", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" }) end
		if client:supports_method('textDocument/rename') then vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]ename variable"}) end
		if client:supports_method('textDocument/completion') then
			-- Tweak autocomplete list behaviour
			vim.cmd [[set completeopt+=menuone,noselect,popup]]
			-- Enable autocompletion
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
			vim.keymap.set("i", "<C-Space>", function() vim.lsp.completion.get() end,
				{ desc = "Open autocomplete" })
		end
	end
})


