return {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    config = function()
        require("gitsigns").setup()

        vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>")
        vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>")
    end,
}
