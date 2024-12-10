return {
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>ha", ':lua require("harpoon.mark").add_file()<CR>', desc = "[H]arpoon [a]dd", silent = true },
        {
            "<leader>hf",
            ':lua require("harpoon.ui").toggle_quick_menu()<CR>',
            desc = "[H]arpoon [f]ind files",
            silent = true,
        },

        { "<leader>1", ':lua require("harpoon.ui").nav_file(1)<CR>', desc = "[H]arpoon file [1]", silent = true },
        { "<leader>2", ':lua require("harpoon.ui").nav_file(2)<CR>', desc = "[H]arpoon file [2]", silent = true },
        { "<leader>3", ':lua require("harpoon.ui").nav_file(3)<CR>', desc = "[H]arpoon file [3]", silent = true },
        { "<leader>4", ':lua require("harpoon.ui").nav_file(4)<CR>', desc = "[H]arpoon file [4]", silent = true },
        { "<leader>5", ':lua require("harpoon.ui").nav_file(5)<CR>', desc = "[H]arpoon file [5]", silent = true },
    },
}
