return {
    'f-person/git-blame.nvim',

    config = function()
        local gitblame = require('gitblame')
        local keymap = vim.keymap

        gitblame.setup {
            enabled = false,
            keymap.set('n', '<leader>gb', ':GitBlameToggle<CR>')
        }
    end
}
