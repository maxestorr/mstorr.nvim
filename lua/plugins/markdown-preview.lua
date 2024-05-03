return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
        vim.fn["mkdp#util#install"]()
    end,

    config = function()
        local keymap = vim.keymap

        keymap.set(
            "n",
            "<leader>md",
            ":MarkdownPreviewToggle<CR>",
            { noremap = true, silent = true, desc = "Markdown preview toggle" }
        )
    end,
}
