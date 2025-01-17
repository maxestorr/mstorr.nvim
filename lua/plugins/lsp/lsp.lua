return {

    {
        "saghen/blink.cmp",
        version = "*",

        dependencies = {
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
            {
                "kristijanhusak/vim-dadbod-completion",
                ft = { "sql", "mysql", "plsql" },
                lazy = true,
            },
            -- Snippet engines
            -- "L3MON4D3/LuaSnip",
        },

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = "default" },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                providers = {
                    dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                },
            },
        },

        opts_extend = { "sources.default" },
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },

        event = { "BufReadPre", "BufNewFile" },

        config = function()
            local lspconfig = require("lspconfig")
            local blink_cmp = require("blink.cmp")

            local keymap = vim.keymap
            local opts = { noremap = true, silent = true }
            local capabilities = blink_cmp.get_lsp_capabilities()

            local on_attach = function(client, bufnr)
                opts.buffer = bufnr

                keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                keymap.set("n", "K", vim.lsp.buf.hover, opts)
                -- keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
                keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                keymap.set("n", "gr", vim.lsp.buf.references, opts)
                keymap.set("n", "]d", vim.diagnostic.goto_next)
                keymap.set("n", "[d", vim.diagnostic.goto_prev)

                -- Use null-ls for formatting in normal or visual mode
                keymap.set({ "n", "v" }, "<space>f", function()
                    local null_ls_sources = require("null-ls.sources")
                    local ft = vim.bo[bufnr].filetype
                    local has_null_ls = #null_ls_sources.get_available(ft, "NULL_LS_FORMATTING") > 0

                    vim.lsp.buf.format({
                        bufnr = bufnr,
                        filter = function(client)
                            if has_null_ls then
                                return client.name == "null-ls"
                            else
                                return true
                            end
                        end,
                    })
                end, opts)
            end

            require("mason-lspconfig").setup_handlers({
                -- default handler
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,

                -- custom handlers
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = {
                            Lua = {
                                diagonstics = {
                                    globals = { "vim" },
                                },
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                        [vim.fn.stdpath("config") .. "/lua"] = true,
                                    },
                                },
                            },
                        },
                    })
                end,

                ["pyright"] = function()
                    lspconfig.pyright.setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = {
                            python = {
                                venvPath = ".",
                                -- Have to set venv folder in pyproject.toml instead
                                -- venv = ".venv", -- WHY ISNT THIS A SETTING!?!?!?
                                analysis = {
                                    exclude = { ".venv" },
                                    -- workspace mode lags on large projects
                                    -- diagnosticMode = "workspace",
                                    diagnosticMode = "openFilesOnly",
                                },
                            },
                        },
                    })
                end,
            })
        end,

        -- -- example using `opts` for defining servers
        -- opts = {
        --     servers = {
        --         lua_ls = {},
        --     },
        -- },

        -- config = function(_, opts)
        --     local lspconfig = require("lspconfig")
        --     for server, config in pairs(opts.servers) do
        --         -- passing config.capabilities to blink.cmp merges with the capabilities in your
        --         -- `opts[server].capabilities, if you've defined it
        --         config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        --         lspconfig[server].setup(config)
        --     end
        -- end,
    },

    {
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
