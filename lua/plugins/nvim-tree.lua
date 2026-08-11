local config = {
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 35,
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

-- Have nvim tree open on startup
api.tree.toggle({
    path = "<args>",
    find_file = false,
    update_root = false,
    focus = true,
})

-- Have nvim-tree focus on active buffer.
vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if (vim.fn.bufname() == "NvimTree_1") then return end

        api.tree.find_file({ buf = vim.fn.bufnr() })
    end,
})
