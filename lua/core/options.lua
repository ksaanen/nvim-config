-- -----------------------
-- Custom options
-- -----------------------

-- keybfndings
vim.opt.keywordprg = ":help" -- bind 'K' to :help [keyword]

-- linenumbers
vim.opt.number = true
vim.opt.relativenumber = true

-- ignore files
vim.opt.wildignore:append({ "**/node_modules/*", "**/.git/*", "**/.vs/*" })

-- Optionally enable 24-bit colour
vim.opt.termguicolors = true

vim.opt.winborder = "rounded"

-- Smart searching
-- '/pattern' will search case insensitive.
-- '/Pattern' will search case sensitive because op the capital P.
-- '/pattern\C' will search case sensitive
-- '/Pattern\c' will search case insensitive
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- for preview while search/replace
vim.opt.inccommand = "split"
