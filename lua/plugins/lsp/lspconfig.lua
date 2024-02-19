return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }
        local capabilities = cmp_nvim_lsp.default_capabilities()

        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            -- Todo: include doc string for below definition
            keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            -- Todo: Work out the difference between buf.hover and buf.signature_help
            -- Todo: Change <C-K> keybind, clashes with select window up
            keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
            keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
            keymap.set('n', '<space>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
            keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
            keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
            keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            keymap.set('n', '<space>f', function()
                vim.lsp.buf.format { async = true }
            end, opts)
        end

        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagonstics = {
                        -- Ignore undefined global variables in this list
                        globals = { "vim" },
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            }
        })

        lspconfig["ansiblels"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["bashls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["jsonls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["pyright"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["sqlls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["yamlls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
}
