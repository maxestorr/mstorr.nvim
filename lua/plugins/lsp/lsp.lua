return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
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

            require("null-ls").setup({
                sources = {
                    -- anything not supported by mason
                },
                on_attach = on_attach,
            })
        end,
    },
}
