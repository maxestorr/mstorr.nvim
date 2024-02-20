return {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>gg", ':LazyGit<CR>', desc = "Lazy[g]it", silent = true },
    },
}
