-- -----------------------
-- Global settings
-- -----------------------

vim.opt.winborder = "rounded"

-- Netrw settings
-- vim.g.netrw_banner = 0 -- Disables help banner at the top of the window
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3

-- Smart searching
-- '/pattern' will search case insensitive.
-- '/Pattern' will search case sensitive because op the capital P.
-- '/pattern\C' will search case sensitive
-- '/Pattern\c' will search case insensitive
vim.opt.ignorecase = true
vim.opt.smartcase = true
