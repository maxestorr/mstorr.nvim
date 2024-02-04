return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-tree/nvim-web-devicons",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local keymap = vim.keymap

            telescope.setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch for [f]iles" })
            keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch via [g]rep" })

            telescope.load_extension("ui-select")
            telescope.load_extension("fzf")
        end,
    },
}
