local blink = require("blink")

blink.setup({
	chartoggle = { enabled = true },
	tree = { enabled = true },
})

vim.keymap.set("n", "<C-e>", "<cmd>BlinkTree reveal<cr>", { desc = "Reveal current file in tree" })
vim.keymap.set("n", "<leader>E", "<cmd>BlinkTree toggle<cr>", { desc = "Reveal current file in tree" })
vim.keymap.set("n", "<leader>e", "<cmd>BlinkTree toggle-focus<cr>", { desc = "Toggle file tree focus" })
