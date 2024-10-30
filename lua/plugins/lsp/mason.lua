return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "jay-babu/mason-null-ls.nvim",
        { "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    },

    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        -- TODO: look into :h mason-lspconfig-automatic-server-setup
        -- I believe this should remove the need for lspconfig.server.setup
        -- lines in ./lspconfig.lua
        require("mason-lspconfig").setup {
            ensure_installed = {
                "lua_ls",
                "bashls",
                "jsonls",
                "pyright",
                "sqlls",
                "yamlls",
                "html",
                "cssls",
                "ts_ls",
            },
            automatic_installation = true,
        }

        require("mason-null-ls").setup({
            ensure_installed = {
                "stylua",
                "isort",
                "black",
            },
            automatic_installation = true,
            handlers = {},
        })

        require("null-ls").setup({
            sources = {
                -- Anything not supported by mason.
            }
        })
    end,
}
