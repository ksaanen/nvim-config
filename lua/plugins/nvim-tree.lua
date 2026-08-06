local config = {
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 50,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
}
require("nvim-tree").setup(config)

local api = require("nvim-tree.api")

vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if (vim.fn.bufname() == "NvimTree_1") then return end

        api.tree.find_file({ buf = vim.fn.bufnr() })
    end,
})
