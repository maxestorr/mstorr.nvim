return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",

        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "jay-babu/mason-null-ls.nvim",
            { "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
        },

        keys = { { "<leader>m", ":Mason<cr>", desc = "[M]ason, LSP installer", silent = true } },

        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "bashls",
                    "sqlls",
                    "jsonls",
                    "yamlls",
                    "terraformls",
                    "dockerls",
                },
                automatic_installation = true,
            })

            require("mason-null-ls").setup({
                ensure_installed = {
                    "stylua",
                    "isort",
                    "black",
                    "yamlfmt",
                },
                automatic_installation = true,
                handlers = {},
            })
        end,
    },
}
