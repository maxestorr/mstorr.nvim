return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<leader>e", ":Neotree toggle position=float<CR>", desc = "Toggle filetree [e]xplorer", silent = true },
    },
    opts = {
        filesystem = {
            filtered_items = {
                visible = true,
                show_hidden_count = true,
                hide_dotfiles = true,
                hide_gitignored = true,
                hide_by_name = {},
                never_show = {},
            },
        },
    },
}
