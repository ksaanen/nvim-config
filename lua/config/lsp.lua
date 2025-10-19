-- -----------------------
-- LSP Configuration
-- -----------------------

vim.lsp.enable("angularls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("ts_ls")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		-- In this case, we create a function that lets us more easily define mappings specific
		-- for LSP related items. It sets the mode, buffer and description for us each time.
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(event.buf, ...)
		end

		buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		-- Mappings.
		map("gD", vim.lsp.buf.declaration, "[G]o to [D]eclaration")
		map("gd", vim.lsp.buf.definition, "[G]o to [D]efinition")
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("gi", vim.lsp.buf.implementation, "[G]o to [I]mplementation")
		map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
		map("<space>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
		map("<space>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
		map("<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "[W]orkspace [L]ist Folders")
		map("<space>D", vim.lsp.buf.type_definition, "Type [D]efinition")
		map("<space>rn", vim.lsp.buf.rename, "[R]e[N]ame")
		map("gr", vim.lsp.buf.references, "[G]o to [R]eferences")
		map("<space>e", vim.diagnostic.open_float, "Show [E]rror")
		map("[d", vim.diagnostic.goto_prev, "Go to previous [D]iagnostic")
		map("]d", vim.diagnostic.goto_next, "Go to next [D]iagnostic")
		map("<space>q", vim.diagnostic.setloclist, "Set [Q]uickfix")
		if client == nil then
			return
		end

		if client:supports_method("textDocument/completion") then
			vim.opt.completeopt = vim.opt.completeopt + { "menu", "menuone", "noinsert", "fuzzy", "popup" }
			vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
			vim.keymap.set("i", "<C-Space>", function()
				vim.lsp.completion.get()
			end)
		end
	end,
})

vim.diagnostic.config({
	virtual_lines = true,
	severity_sort = true,
})

-- Set filetype for Angular component HTML files
-- vim.filetype.add({
--	pattern = {
--		[".*%.component%.html"] = "htmlangular",
--		[".*%-component%.html"] = "htmlangular",
--	},
-- })

-- Disable rust-analyzer diagnostics
vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = false,
			},
		},
	},
})
