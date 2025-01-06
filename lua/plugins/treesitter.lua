return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufRead",
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = true,
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                require("nvim-treesitter.configs").setup({
                    incremental_selection = {
                        enable = true,
                        keymaps = {
                            init_selection = "<C-space>",
                            node_incremental = "<C-space>",
                            scope_incremental = false,
                            node_decremental = "<bs>",
                        },
                    },
                }),
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            enable = true,
            multiwindow = false,
            max_lines = 1,
            min_window_height = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = "outer",
            mode = "cursor",
        },
    },

    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist

                        goto_next_start = {
                            ["]f"] = { query = "@function.outer", desc = "Next function start" },
                            ["]c"] = { query = "@class.outer", desc = "Next class start" },
                            ["]m"] = { query = "@call.outer", desc = "Next call start" },
                            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
                            ["]b"] = { query = "@conditional.outer", desc = "Next conditional start" },
                        },

                        goto_next_end = {
                            ["]F"] = { query = "@function.outer", desc = "Next function end" },
                            ["]C"] = { query = "@class.outer", desc = "Next class end" },
                            ["]M"] = { query = "@call.outer", desc = "Next call end" },
                            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                            ["]B"] = { query = "@conditional.outer", desc = "Next conditional end" },
                        },

                        goto_previous_start = {
                            ["[f"] = { query = "@function.outer", desc = "Previous function start" },
                            ["[c"] = { query = "@class.outer", desc = "Previous class start" },
                            ["[m"] = { query = "@call.outer", desc = "Next call start" },
                            ["[l"] = { query = "@loop.outer", desc = "Next loop start" },
                            ["[b"] = { query = "@conditional.outer", desc = "Next conditional start" },
                        },

                        goto_previous_end = {
                            ["[F"] = { query = "@function.outer", desc = "Previous function end" },
                            ["[C"] = { query = "@class.outer", desc = "Previous class end" },
                            ["[M"] = { query = "@call.outer", desc = "Next call end" },
                            ["[L"] = { query = "@loop.outer", desc = "Next loop end" },
                            ["[B"] = { query = "@conditional.outer", desc = "Next conditional end" },
                        },
                    },

                    select = {
                        enable = true,
                        lookahead = true,

                        keymaps = {
                            ["af"] = { query = "@function.outer", desc = "Around function" },
                            ["if"] = { query = "@function.inner", desc = "Inner function" },

                            ["ac"] = { query = "@class.outer", desc = "Around class" },
                            ["ic"] = { query = "@class.inner", desc = "Inner class" },

                            ["am"] = { query = "@call.outer", desc = "Around call" },
                            ["im"] = { query = "@call.inner", desc = "Inner call" },

                            ["al"] = { query = "@loop.outer", desc = "Outer loop" },
                            ["il"] = { query = "@loop.inner", desc = "Inner loop" },

                            ["ab"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                            ["ib"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
                        },

                        selection_modes = {
                            ["@function.outer"] = "V",
                            ["@function.inner"] = "V",

                            ["@class.outer"] = "V",
                            ["@class.inner"] = "V",

                            ["@loop.outer"] = "V",
                            ["@loop.inner"] = "V",
                        },
                    },
                },
            })
        end,
    },
}
