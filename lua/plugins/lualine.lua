return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/noice.nvim' },

    config = function ()
        local lualine = require('lualine')
        local noice = require('noice')
        local lazy_status = require('lazy.status')

        -- Display message in statusline when recording macro
        -- because noice replaces messages ui we need to forward messages to lualine
        lualine.setup({
            sections = {
                lualine_x = {
                    {
                        noice.api.statusline.mode.get,
                        cond = noice.api.statusline.mode.has,
                        color = { fg = "#ff9e64" },
                    },
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                        color = { fg = "#ff9e64" },
                    },
                },
            },
        })
    end
}
