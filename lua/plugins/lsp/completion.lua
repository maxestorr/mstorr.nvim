-- TODO: nvim-cmp used to intelligently recommend params when calling a function
-- before I even type anything, whereas blink.cmp is recommending from buffer first,
-- how can I fix this?
-- TODO: nvim-cmp also had a pop-up for the function/parameter signature
-- when a completion entry was selected, enable this again

return {
    {
        "saghen/blink.cmp",
        version = "*",
        event = "InsertEnter",

        dependencies = {
            "rafamadriz/friendly-snippets",
            {
                "kristijanhusak/vim-dadbod-completion",
                ft = { "sql", "mysql", "plsql" },
                lazy = true,
            },
            -- I don't know if these are alternatives or add-ons to blink / nvim-cmp
            -- "L3MON4D3/LuaSnip", -- TODO: Work out how to effectively use snippets
            -- "saadparwaiz1/cmp_luasnip", -- FIX: Errors out
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
}
