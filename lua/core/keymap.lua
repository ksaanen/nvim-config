-- -----------------------
-- Custom Keybindings
-- -----------------------

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
-- See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Buffers
vim.keymap.set("n", "<C-b>", ":buffers<cr>:buffer<Space>", { desc = "List buffers and select" })

-- Netrw
vim.keymap.set("n", "<leader>ld", ":Lex %:h<cr>", { desc = "Toggle Netrw [L]explore current [D]irectory" })
vim.keymap.set("n", "<leader>le", ":Lex<cr>", { desc = "Toggle Netrw [L]explore" })
vim.keymap.set("n", "<leader>ve", ":Vex<cr>", { desc = "Open Netrw [V]explore" })
vim.keymap.set("n", "<leader>e", ":Ex<cr>", { desc = "Open Netrw [E]plore" })

-- Marks
--vim.keymap.set("n", "<C-m>", ":marks<cr>:mark<Space>", { desc = "List marks and select" })
vim.keymap.set("n", "<leader>ml", ":marks<cr>", { desc = "[M]arks [L]ist" })
vim.keymap.set("n", "<leader>md!", ":delm!<cr>", { desc = "[M]arks [D]elete all in current buffer" })

local chars = "abcdefghijklmnopqrstuvwxyz0123456789"
for i = 1, #chars do
	local lower_letter = chars:sub(i, i)
	local upper_letter = string.upper(lower_letter)
	vim.keymap.set("n", "<leader>gm" .. lower_letter, "'" .. lower_letter .. "<cr>",
		{ desc = "[G]o to [M]ark " .. upper_letter })
	vim.keymap.set("n", "<leader>md" .. lower_letter, ":delm " .. lower_letter .. "<cr>",
		{ desc = "[M]ark [D]elete " .. upper_letter })
end

local function vimgrep_pattern()
	local pattern = vim.fn.input("vimgrep pattern:")
	vim.api.nvim_command(":vimgrep /" .. pattern .. "/g **/* <CR>")
end
vim.keymap.set("n", "<leader>vg", function() vimgrep_pattern() end, { desc = "[V]im[G]rep a string" })
vim.keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "[Q]uickFix [O]pen list" })
vim.keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "[Q]uickFix [C]lose list" })

-- Telescope
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "[F]ind live [G]rep" })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "[F]ind [H]elper tags" })
vim.keymap.set("n", "<leader>fk", telescope_builtin.keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fd", telescope_builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>fr", telescope_builtin.resume, { desc = "[F]ind [R]esume" })

-- Lsp
vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, { desc = "[W]orkspace [A]dd Folder" })
vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, { desc = "[W]orkspace [R]emove Folder" })
vim.keymap.set("n", "<space>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "[W]orkspace [L]ist Folders" })
