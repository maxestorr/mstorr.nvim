return {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    event = "VeryLazy",
    dependencies = {
        "neovim/nvim-lspconfig",
        -- "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
        { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },

    keys = {
        { "<leader>sv", "<cmd>VenvSelect<cr>" },
    },

    ---@type venv-selector.Config
    opts = {
    },
}
