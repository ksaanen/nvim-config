--[[
-- Configure Copilot (default option)
vim.pack.add({
	-- Copilot
	-- run ':Copilot setup' for initial config
	-- run ':help copilot' for docs
	{ src = 'https://github.com/github/copilot.vim' },
})

-- Configure Copilot with Github Enterprise (alternative option)
vim.pack.add({
	-- Copilot
	-- run ':Copilot setup' for initial config
	-- run ':help copilot' for docs
	{ src = 'https://github.com/zbirenbaum/copilot.lua' },
})
require("copilot").setup({
	-- Replace with your company's GHE URL
	auth_provider_url = "https://<ghe-company-url>.ghe.com",

	filetypes = {
		javascript = true, -- allow specific filetype
		typescript = true, -- allow specific filetype
		lua = true, -- allow specific filetype
		["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
	},
	
	suggestion = {
		enabled = true,
		auto_trigger = true,
		
		-- Keymap configuration <M stants for the Alt key, so <M-l> means Alt + l
		keymap = {
			accept = "<M-l>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},
	},

	panel = {
		enabled = false,
	},
	
	copilot_node_command = "node", -- Node >=22
})
]]
