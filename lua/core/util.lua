return {
	-- List all active marks into the quickfix list
	list_marks_in_quickfix = function()
		local marks = vim.fn.getmarklist()
		local qf_entries = {}
		for _, m in ipairs(marks) do
			if m.file and m.pos[2] > 0 then -- skip invalid marks
				table.insert(qf_entries, {
					filename = m.file,
					lnum = m.pos[2],
					col = m.pos[3],
					text = string.format("mark %s", m.mark),
				})
			end
		end
		vim.fn.setqflist(qf_entries, 'r')
		vim.cmd("copen")
	end,

	-- Combine pattern in :vimgrep command
	vimgrep_pattern = function()
		local pattern = vim.fn.input("vimgrep pattern:")
		vim.api.nvim_command(":vimgrep /" .. pattern .. "/g **/* <CR>")
	end,

	-- List Code actions in Quickfix list
	list_code_actions_in_quickfix = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local params = vim.lsp.util.make_range_params(0, "utf-8")
		params.context = { diagnostics = vim.diagnostic.get(bufnr) }

		vim.lsp.buf_request_all(bufnr, 'textDocument/codeAction', params, function(results)
			local actions = {}
			for _, res in pairs(results or {}) do
				if res.result then
					vim.list_extend(actions, res.result)
				end
			end

			if vim.tbl_isempty(actions) then
				vim.notify("No code actions available", vim.log.levels.INFO)
				return
			end

			local qf_entries = {}
			for i, action in ipairs(actions) do
				table.insert(qf_entries, {
					bufnr = bufnr,
					lnum = vim.api.nvim_win_get_cursor(0)[1],
					col = 1,
					text = action.title,
				})
			end
			_G._code_actions = actions
			vim.fn.setqflist({}, ' ', { title = 'Code Actions', items = qf_entries })
			vim.cmd("copen")
		end)
	end,

	-- Apply Code Action under current cursor position
	apply_code_action_from_quickfix = function()
		local qf_idx = vim.fn.getqflist({ idx = 0 }).idx
		local action = _G._code_actions and _G._code_actions[qf_idx]
		if not action then
			vim.notify("No code action selected", vim.log.levels.WARN)
			return
		end
		if action.edit then
			vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
		end
		if action.command then
			vim.lsp.buf.execute_command(action.command)
		end
	end
}
