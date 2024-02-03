-- options.lua
--
-- Changing Neovim's option settings
-- See `:help vim.o`

vim.o.mouse = 'a'

vim.o.number = true
vim.o.relativenumber = true

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.scrolloff = 6

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'
vim.o.colorcolumn = '80'

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

-- Indent wrapped lines
vim.o.breakindent = true

-- Show autocomplete menu but require manual selection
vim.o.completeopt = 'menuone,noselect'

-- Enable 24-bit colors
vim.o.termguicolors = true
