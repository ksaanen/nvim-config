-- ============================================================================
-- LSP Configuration
-- ============================================================================
-- Requires:
--   - Neovim 0.11+
--   - nvim-lspconfig
--
-- Architecture:
--   * vim.lsp.config() / vim.lsp.enable() only
--   * One shared LspAttach handler
--   * Built-in LSP completion
--   * Biome owns formatting/fixes for JS/TS/CSS/etc.
--   * tsgo provides TypeScript/JavaScript language intelligence
--   * rust-analyzer diagnostics disabled
-- ============================================================================


-- ============================================================================
-- Shared LSP behavior
-- ============================================================================

local function on_attach(client, bufnr)
	-- --------------------------------------------------------------------------
	-- Built-in LSP completion
	-- --------------------------------------------------------------------------
	--
	-- Neovim 0.11+ supports completion directly through vim.lsp.completion.
	--
	-- `convert` removes function signatures from the completion menu while
	-- retaining the original completion item underneath.
	--
	vim.lsp.completion.enable(true, client.id, bufnr, {
		autotrigger = true,

		convert = function(item)
			return {
				abbr = item.label:gsub("%b()", ""),
			}
		end,
	})

	vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, {
		buffer = bufnr,
		desc = "Trigger LSP completion",
	})
end


-- ============================================================================
-- Server configuration
-- ============================================================================

-- Lua
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},

			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},

			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},

			telemetry = {
				enable = false,
			},
		},
	},
})


-- Rust
--
-- rust-analyzer remains enabled for:
--   * completion
--   * hover
--   * navigation
--   * code actions
--   * semantic information
--
-- but diagnostics are disabled because another tool/workflow is handling them.
vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = false,
			},
		},
	},
})

-- ESLint config
vim.lsp.config("eslint", {
    settings = {
        workingDirectories = {
            mode = "auto",
        },
    },

    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.code_action({
                    context = {
                        only = {
                            "source.fixAll.eslint",
                        },
                        diagnostics = {},
                    },
                    apply = true,
                })
            end,
        })
    end,
})

-- ============================================================================
-- Formatting policy
-- ============================================================================

-- Servers that should NOT participate in automatic formatting.
--
-- This is particularly important for JS/TS where tsgo and Biome can both
-- expose formatting capabilities.
local formatters = {
	biome = true,
	eslint = true,
}


local function format_on_save(client, bufnr)
	-- Only Biome is allowed to format automatically.
	if not formatters[client.name] then
		return
	end

	if not client:supports_method("textDocument/formatting") then
		return
	end

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup(
			"LspFormat." .. client.id,
			{ clear = true }
		),
		buffer = bufnr,

		callback = function()
			vim.lsp.buf.format({
				bufnr = bufnr,
				id = client.id,
				timeout_ms = 1000,
			})
		end,
	})
end


-- ============================================================================
-- Biome fix-all on save
-- ============================================================================

local function biome_fix_on_save(client, bufnr)
	if client.name ~= "biome" then
		return
	end

	if not client:supports_method("textDocument/codeAction") then
		return
	end

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup(
			"BiomeFix." .. client.id,
			{ clear = true }
		),
		buffer = bufnr,

		callback = function()
			vim.lsp.buf.code_action({
				context = {
					only = {
						"source.fixAll.biome",
					},
					diagnostics = {},
				},

				-- Apply automatically when there is exactly one action.
				apply = true,
			})
		end,
	})
end


-- ============================================================================
-- LspAttach
-- ============================================================================

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", { clear = true }),

	callback = function(args)
		local client = assert(
			vim.lsp.get_client_by_id(args.data.client_id)
		)

		local bufnr = args.buf

		-- Shared behavior for every server.
		on_attach(client, bufnr)

		-- Only configured formatter(s) format on save.
		format_on_save(client, bufnr)

		-- Biome-specific source.fixAll action.
		biome_fix_on_save(client, bufnr)
	end,
})


-- ============================================================================
-- Enable language servers
-- ============================================================================

vim.lsp.enable({
	"angularls",
	"lua_ls",
	"rust_analyzer",
	"tsgo",
	"somesass_ls",
	"biome",
	"eslint"
})


-- ============================================================================
-- Diagnostics
-- ============================================================================

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	severity_sort = true,

	float = {
		border = "rounded",
		source = true,
	},

	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},

		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})


-- ============================================================================
-- Utility commands
-- ============================================================================

local function restart_lsp(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	local clients = vim.lsp.get_clients({
		bufnr = bufnr,
	})

	for _, client in ipairs(clients) do
		client:stop()
	end

	vim.defer_fn(function()
		vim.cmd("edit")
	end, 100)
end


vim.api.nvim_create_user_command("LspRestart", function()
	restart_lsp()
end, {
	desc = "Restart LSP clients for the current buffer",
})


-- ============================================================================
-- LSP Status
-- ============================================================================

local function lsp_status()
	local bufnr = vim.api.nvim_get_current_buf()

	local clients = vim.lsp.get_clients({
		bufnr = bufnr,
	})

	if #clients == 0 then
		print("󰅚 No LSP clients attached")
		return
	end

	print("󰒋 LSP Status for buffer " .. bufnr)
	print("─────────────────────────────────")

	for i, client in ipairs(clients) do
		print(string.format(
			"󰌘 Client %d: %s (ID: %d)",
			i,
			client.name,
			client.id
		))

		print("  Root: " .. (client.config.root_dir or "N/A"))

		print(
			"  Filetypes: "
				.. table.concat(client.config.filetypes or {}, ", ")
		)

		local caps = client.server_capabilities

		if not caps then
			print("")
			goto continue
		end

		local features = {}

		if caps.completionProvider then
			table.insert(features, "completion")
		end

		if caps.hoverProvider then
			table.insert(features, "hover")
		end

		if caps.definitionProvider then
			table.insert(features, "definition")
		end

		if caps.referencesProvider then
			table.insert(features, "references")
		end

		if caps.renameProvider then
			table.insert(features, "rename")
		end

		if caps.codeActionProvider then
			table.insert(features, "code_action")
		end

		if caps.documentFormattingProvider then
			table.insert(features, "formatting")
		end

		print("  Features: " .. table.concat(features, ", "))
		print("")

		::continue::
	end
end


vim.api.nvim_create_user_command("LspStatus", lsp_status, {
	desc = "Show detailed LSP status",
})


-- ============================================================================
-- LSP Capabilities
-- ============================================================================

local function check_lsp_capabilities()
	local bufnr = vim.api.nvim_get_current_buf()

	local clients = vim.lsp.get_clients({
		bufnr = bufnr,
	})

	if #clients == 0 then
		print("󰅚 No LSP clients attached")
		return
	end

	for _, client in ipairs(clients) do
		print("Capabilities for " .. client.name .. ":")

		local caps = client.server_capabilities

		if not caps then
			print("  No capabilities reported")
			print("")
			goto continue
		end

		local capability_list = {
			{ "Completion", caps.completionProvider },
			{ "Hover", caps.hoverProvider },
			{ "Signature Help", caps.signatureHelpProvider },
			{ "Go to Definition", caps.definitionProvider },
			{ "Go to Declaration", caps.declarationProvider },
			{ "Go to Implementation", caps.implementationProvider },
			{ "Go to Type Definition", caps.typeDefinitionProvider },
			{ "Find References", caps.referencesProvider },
			{ "Document Highlight", caps.documentHighlightProvider },
			{ "Document Symbol", caps.documentSymbolProvider },
			{ "Workspace Symbol", caps.workspaceSymbolProvider },
			{ "Code Action", caps.codeActionProvider },
			{ "Code Lens", caps.codeLensProvider },
			{ "Document Formatting", caps.documentFormattingProvider },
			{ "Document Range Formatting", caps.documentRangeFormattingProvider },
			{ "Rename", caps.renameProvider },
			{ "Folding Range", caps.foldingRangeProvider },
			{ "Selection Range", caps.selectionRangeProvider },
		}

		for _, capability in ipairs(capability_list) do
			local status = capability[2] and "✓" or "✗"

			print(string.format(
				"  %s %s",
				status,
				capability[1]
			))
		end

		print("")

		::continue::
	end
end


vim.api.nvim_create_user_command("LspCapabilities", check_lsp_capabilities, {
	desc = "Show LSP capabilities",
})


-- ============================================================================
-- Diagnostics summary
-- ============================================================================

local function lsp_diagnostics_info()
	local bufnr = vim.api.nvim_get_current_buf()

	local diagnostics = vim.diagnostic.get(bufnr)

	local counts = {
		ERROR = 0,
		WARN = 0,
		INFO = 0,
		HINT = 0,
	}

	for _, diagnostic in ipairs(diagnostics) do
		local severity = vim.diagnostic.severity[diagnostic.severity]

		if counts[severity] then
			counts[severity] = counts[severity] + 1
		end
	end

	print("󰒡 Diagnostics for current buffer:")
	print("  Errors: " .. counts.ERROR)
	print("  Warnings: " .. counts.WARN)
	print("  Info: " .. counts.INFO)
	print("  Hints: " .. counts.HINT)
	print("  Total: " .. #diagnostics)
end


vim.api.nvim_create_user_command("LspDiagnostics", lsp_diagnostics_info, {
	desc = "Show LSP diagnostics count",
})


-- ============================================================================
-- Comprehensive LSP information
-- ============================================================================

local function lsp_info()
	local bufnr = vim.api.nvim_get_current_buf()

	local clients = vim.lsp.get_clients({
		bufnr = bufnr,
	})

	print("═══════════════════════════════════")
	print("           LSP INFORMATION          ")
	print("═══════════════════════════════════")
	print("")

	print("󰈙 Language client log: " .. vim.lsp.get_log_path())
	print("󰈔 Detected filetype: " .. vim.bo.filetype)
	print("󰈮 Buffer: " .. bufnr)
	print("󰈔 Root directory: " .. vim.fn.getcwd())
	print("")

	if #clients == 0 then
		print("󰅚 No LSP clients attached to buffer " .. bufnr)
		print("")
		print("Possible reasons:")
		print("  • No language server installed for " .. vim.bo.filetype)
		print("  • Language server not configured")
		print("  • Not in a project root directory")
		print("  • File type not recognized")
		return
	end

	print("󰒋 LSP clients attached to buffer " .. bufnr .. ":")
	print("─────────────────────────────────")

	for i, client in ipairs(clients) do
		print(string.format(
			"󰌘 Client %d: %s",
			i,
			client.name
		))

		print("  ID: " .. client.id)
		print("  Root dir: " .. (client.config.root_dir or "Not set"))

		print(
			"  Command: "
				.. table.concat(client.config.cmd or {}, " ")
		)

		print(
			"  Filetypes: "
				.. table.concat(client.config.filetypes or {}, ", ")
		)

		print(
			"  Status: "
				.. (client:is_stopped() and "󰅚 Stopped" or "󰄬 Running")
		)

		-- Workspace folders.
		if client.workspace_folders and #client.workspace_folders > 0 then
			print("  Workspace folders:")

			for _, folder in ipairs(client.workspace_folders) do
				print("    • " .. folder.name)
			end
		end

		-- Attached buffers.
		local attached_buffers = {}

		for buf in pairs(client.attached_buffers or {}) do
			table.insert(attached_buffers, buf)
		end

		print("  Attached buffers: " .. #attached_buffers)

		-- Key capabilities.
		local caps = client.server_capabilities

		if caps then
			local features = {}

			if caps.completionProvider then
				table.insert(features, "completion")
			end

			if caps.hoverProvider then
				table.insert(features, "hover")
			end

			if caps.definitionProvider then
				table.insert(features, "definition")
			end

			if caps.documentFormattingProvider then
				table.insert(features, "formatting")
			end

			if caps.codeActionProvider then
				table.insert(features, "code_action")
			end

			if #features > 0 then
				print(
					"  Key features: "
						.. table.concat(features, ", ")
				)
			end
		end

		print("")
	end

	-- Diagnostics summary.
	local diagnostics = vim.diagnostic.get(bufnr)

	if #diagnostics > 0 then
		print("󰒡 Diagnostics Summary:")

		local counts = {
			ERROR = 0,
			WARN = 0,
			INFO = 0,
			HINT = 0,
		}

		for _, diagnostic in ipairs(diagnostics) do
			local severity = vim.diagnostic.severity[diagnostic.severity]

			if counts[severity] then
				counts[severity] = counts[severity] + 1
			end
		end

		print("  󰅚 Errors: " .. counts.ERROR)
		print("  󰀪 Warnings: " .. counts.WARN)
		print("  󰋽 Info: " .. counts.INFO)
		print("  󰌶 Hints: " .. counts.HINT)
		print("  Total: " .. #diagnostics)
	else
		print("󰄬 No diagnostics")
	end

	print("")
	print("Use :checkhealth vim.lsp for LSP health information")
	print("Use :LspCapabilities for full capability list")
end


vim.api.nvim_create_user_command("LspInfo", lsp_info, {
	desc = "Show comprehensive LSP information",
})
