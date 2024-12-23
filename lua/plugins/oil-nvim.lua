return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    keys = {
        { "-", ":Oil --float<cr>", desc = "Open current directory in oil" },
    },

    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true,
            },
        })
    end,
}
