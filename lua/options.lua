-- options.lua
--
-- Changing Neovim's option settings
-- See `:help vim.o`

local opt = vim.opt
local wopt = vim.wo

opt.mouse = "a"

opt.number = true
opt.relativenumber = true
opt.cursorline = true

opt.hlsearch = false
opt.incsearch = true

opt.expandtab = true
opt.tabstop = 8
opt.shiftwidth = 4

opt.scrolloff = 6
opt.sidescrolloff = 6
opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.laststatus = 3

opt.splitright = true
opt.splitbelow = true

opt.updatetime = 250
opt.timeoutlen = 300

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.completeopt = "menuone,noselect"

opt.termguicolors = true

opt.list = true -- Show some invisible characters (tabs...
opt.confirm = true -- Show confirm menu when quitting

opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

-- Fold using treesitter
wopt.foldlevel = 99
wopt.foldmethod = 'expr'
wopt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'


opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

vim.filetype.add({ extension = { tf = "terraform" } })
vim.lsp.set_log_level("off")  -- Disable lsp logs, enable for debugging
