-- -----------------------
-- Custom options
-- -----------------------

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- keybfndings
vim.opt.keywordprg = ":help" -- bind 'K' to :help [keyword]

-- linenumbers
vim.opt.number = true
vim.opt.relativenumber = true

-- ignore files
vim.opt.wildignore:append({ "**/node_modules/*", "**/.git/*", "**/.vs/*" })
