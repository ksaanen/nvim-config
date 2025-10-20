local spinner_icons = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spinner_index = 1

require("mini.statusline").setup({
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 75 })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })
			local lsp = MiniStatusline.section_lsp({ trunc_width = 80 })

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics, lsp } },
				"%<",
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=",
				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
				{ hl = "MiniStatuslineLocation", strings = { location } },
			})
		end,
	},
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		spinner_index = (spinner_index % #spinner_icons) + 1
		vim.cmd("redrawstatus")
	end,
})

vim.api.nvim_create_autocmd({ "LspProgress", "User" }, {
	pattern = "*",
	callback = function()
		vim.cmd("redrawstatus")
	end,
})

function MiniStatusline.section_lsp(args)
	if rawget(vim, "lsp") == nil then
		return ""
	end
	local clients = vim.lsp.get_active_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end

	local status = vim.lsp.status() or ""
	status = status:gsub("%%", "%%%%")

	local icon = (status ~= "") and spinner_icons[spinner_index] or ""

	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end

	local lsp_info = icon .. " " .. table.concat(names, ", ")
	if status ~= "" then
		lsp_info = lsp_info .. " " .. status
	end

	return lsp_info
end
