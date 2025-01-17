-- TODO: Refactor this to not return several configs in a single spec
return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "jay-babu/mason-null-ls.nvim",
        { "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
        { "neovim/nvim-lspconfig", dependencies = { "hrsh7th/cmp-nvim-lsp" } },
    },
    event = { "BufReadPre", "BufNewFile" },

    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }
        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- Autoformat on save
        -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        -- if client.supports_method("textDocument/formatting") then
        --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        --     vim.api.nvim_create_autocmd("BufWritePre", {
        --         group = augroup,
        --         buffer = bufnr,
        --         callback = function()
        --             local null_ls_sources = require("null-ls.sources")
        --             local ft = vim.bo[bufnr].filetype
        --             local has_null_ls = #null_ls_sources.get_available(ft, "NULL_LS_FORMATTING") > 0
        --
        --             vim.lsp.buf.format({
        --                 bufnr = bufnr,
        --                 filter = function(client)
        --                     if has_null_ls then
        --                         return client.name == "null-ls"
        --                     else
        --                         return true
        --                     end
        --                 end,
        --             })
        --         end,
        --     })
        -- end

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
            keymap.set("n", "]d", vim.diagnostic.goto_next)
            keymap.set("n", "[d", vim.diagnostic.goto_prev)

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
                "ts_ls",
                "bashls",
                "sqlls",
                "jsonls",
                "yamlls",
                "html",
                "cssls",
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
}
