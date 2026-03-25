-- -----------------------
-- Global settings
-- -----------------------

-- Netrw settings
-- vim.g.netrw_banner = 0 -- Disables help banner at the top of the window
-- vim.g.netrw_preview = 1
-- vim.g.netrw_winsize = 20
-- vim.g.netrw_liststyle = 3
-- Some globals need a function that only get's available after initialization:
--vim.api.nvim_create_autocmd("VimEnter", {
--	callback = function()
--		vim.g.netrw_list_hide = vim.fn['netrw_gitignore#Hide']() .. [[.git/]] -- see `:help netrw-gitignore`
--	end
--})

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw (for Nvim Tree plugin) 
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


