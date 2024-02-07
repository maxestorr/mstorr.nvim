-- TODO: I'm meant to set vim.notify = require("notify")
--      but I'm not sure about the best place to do this yet
--      this sets vim's default notifications to use nvim-notify
return {
    'rcarriga/nvim-notify',
    dependencies = { 'mrded/nvim-lsp-notify' },
    init = function()
        require('notify').setup()
        require('lsp-notify').setup({
            notify = require('notify'),
        })
    end
}
