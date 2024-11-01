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

        -- TODO: Look into using default nvim-lspconfig augroup
        -- TODO: include doc string for below definition
        -- TODO: Work out the difference between buf.hover and buf.signature_help
        -- TODO: Change <C-K> keybind, clashes with select window up
        -- TODO: Look into vim.lsp.buf.METHOD{on_list=on_list} to set custom
        -- on_list handlers such as trouble, instead of opening default qfixlist
        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            keymap.set("n", "K", vim.lsp.buf.hover, opts)
            -- keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
            keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
            keymap.set("n", "<space>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
            keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
            keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
            keymap.set("n", "gr", vim.lsp.buf.references, opts)
            keymap.set("n", "<space>f", function()
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

        lspconfig.lua_ls.setup({
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
            },
        })

        lspconfig.bashls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig.jsonls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- TODO: couldn't work out reading .venv from project root
        -- opted for pyproject.toml instead
        lspconfig.pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig.sqlls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig.html.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig.cssls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig.yamlls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig.ts_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig.jdtls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
        lspconfig.terraformls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })
    end,
}
