return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",

        "dhruvasagar/vim-prosession", -- Search vim sessions
        "stevearc/dressing.nvim",     -- Make vim.ui-select/input use telescope
    },

    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local keymap = vim.keymap

        keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch for [f]iles" })
        keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch via [g]rep" })
        keymap.set("n", "<leader>sp", ":Telescope prosession<CR>", { desc = "[S]earch vim [p]rosessions" })

        telescope.load_extension("fzf")
        telescope.load_extension("prosession")
    end,
}
