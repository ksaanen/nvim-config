-- -----------------------
-- Custom Keybindings
-- -----------------------
local util = require("core.util");
local telescope_builtin = require("telescope.builtin")

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
vim.keymap.set("n", "<leader>qm", function() util.list_marks_in_quickfix() end, { desc = "[M]arks to [Q]uickfix list" })
vim.keymap.set("n", "<leader>md!", ":delm!<cr>", { desc = "[M]arks [D]elete all in current buffer" })
vim.keymap.set("n", "<leader>vg", function() util.vimgrep_pattern() end, { desc = "[V]im[G]rep a string" })
vim.keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "[Q]uickfix list [O]pen" })
vim.keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "[Q]uickfix list [C]lose" })
vim.keymap.set("n", "<leader>qa", function()
	util.list_code_actions_in_quickfix()
	util.apply_code_action_from_quickfix() end,
	{ desc = "[Q]uickfix from code [A]ctions" })

-- Telescope
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

-- Code actions
vim.keymap.set("n", "<leader>am",
	function() vim.lsp.buf.code_action({ apply = true, context = { only = "source.addMissingImports" } }) end,
	{ desc = "[A]dd [M]issing imports" })
vim.keymap.set("n", "<leader>fa",
	function() vim.lsp.buf.code_action({ apply = true, context = { only = "source.fixAll" } }) end,
	{ desc = "[F]ix [A]ll issues" })
