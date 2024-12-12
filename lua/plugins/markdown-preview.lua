-- TODO: This repo is no longer supported, look for alternative
return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = ":call mkdp#util#install()",
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
