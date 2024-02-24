-- TODO: Scoped visual motions, e.g.
-- TODO: select inner function
-- TODO: select inner comment
-- TODO: increment and decrement scope seletion
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "lua",
                "vim",
                "vimdoc",
            },
            auto_install = true,
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
 }
