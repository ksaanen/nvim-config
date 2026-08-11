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

-- prevent the built-in vim.lsp.completion autotrigger from selecting the first item
-- menuone - Use the popup menu also when there is only one match. Useful when there is additional information about the match, e.g., what file it comes from.
-- noselect - Same as “noinsert”, except that no menu item is pre-selected. If both “noinsert” and “noselect” are present, “noselect” has precedence.
-- popup - Show extra information about the currently selected completion in a popup window. Only works in combination with “menu” or “menuone”. Overrides “preview”.
vim.opt.completeopt = { "menuone", "noselect", "popup" } 
