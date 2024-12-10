-- TODO: I'm meant to set vim.notify = require("notify")
--      but I'm not sure about the best place to do this yet
--      this sets vim's default notifications to use nvim-notify
return {
    "rcarriga/nvim-notify",
    opts = {
        timeout = 3000,
        max_height = function()
            return math.floor(vim.o.lines * 0.10)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.40)
        end,
        on_open = function(win)
            vim.api.nvim_win_set_config(win, { zindex = 100 })
        end,
    },
    config = true,
}
