-- -----------------------
-- Global settings
-- -----------------------

vim.opt.winborder = "rounded"

-- Netrw settings
-- vim.g.netrw_banner = 0 -- Disables help banner at the top of the window
vim.g.netrw_preview = 1
vim.g.netrw_winsize = 20
vim.g.netrw_liststyle = 3

-- Some globals need a function that only get's available after initialization:
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.g.netrw_list_hide = vim.fn['netrw_gitignore#Hide']() .. [[.git/]] -- see `:help netrw-gitignore`
	end
})

-- Smart searching
-- '/pattern' will search case insensitive.
-- '/Pattern' will search case sensitive because op the capital P.
-- '/pattern\C' will search case sensitive
-- '/Pattern\c' will search case insensitive
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- for preview while search/replace
vim.opt.inccommand = "split"
