return {
    'ThePrimeagen/harpoon',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    keys = {
        { "<leader>ha", ':lua require("harpoon.mark").add_file()<CR>', desc = "[H]arpoon [a]dd" },
        { "<leader>hf", ':lua require("harpoon.ui").toggle_quick_menu()<CR>', desc = "[H]arpoon [f]ind files"},

        { "<leader>1", ':lua require("harpoon.ui").nav_file(1)<CR>', desc = "[H]arpoon file [1]"},
        { "<leader>2", ':lua require("harpoon.ui").nav_file(2)<CR>', desc = "[H]arpoon file [2]"},
        { "<leader>3", ':lua require("harpoon.ui").nav_file(3)<CR>', desc = "[H]arpoon file [3]"},
        { "<leader>4", ':lua require("harpoon.ui").nav_file(4)<CR>', desc = "[H]arpoon file [4]"},
        { "<leader>5", ':lua require("harpoon.ui").nav_file(5)<CR>', desc = "[H]arpoon file [5]"},
    },
}
