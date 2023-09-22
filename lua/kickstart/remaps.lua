-- remaps.lua
--
-- Basic remaps for a better default experience
-- See `:help vim.keymap.set()`

-- Utility functions to reduce repetition of vim.keymap.set()
local Remap = require 'kickstart.keymap'
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap
local tnoremap = Remap.tnoremap

local silent = { silent = true }
local expr = { expr = true }

inoremap('jk', '<esc>', { desc = 'Exit insert mode' })

nnoremap('<C-L>', '<C-W><C-L>', { desc = 'Select window right' })
nnoremap('<C-H>', '<C-W><C-H>', { desc = 'Select window left' })
nnoremap('<C-K>', '<C-W><C-K>', { desc = 'Select window up' })
nnoremap('<C-J>', '<C-W><C-J>', { desc = 'Select window down' })

-- Keep window centered when navigating
nnoremap('<C-d>', '<C-d>zz') -- Down half page
nnoremap('<C-u>', '<C-u>zz') -- Up half page
nnoremap('n', 'nzzzv')       -- Next search item
nnoremap('N', 'Nzzzv')       -- Previous search item

-- Keep cursor position / selection when joining or indenting
nnoremap('J', 'mzJ`z')
vnoremap('>', '>gv')
vnoremap('<', '<gv')

vnoremap('J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
vnoremap('K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })

xnoremap('<leader>p', '"_dp', { desc = 'Paste without overriding current buffer' })

nnoremap('<leader>y', [["+y]], { desc = 'Copy selection to clipboard' })
vnoremap('<leader>y', [["+y]], { desc = 'Copy selection to clipboard' })
nnoremap('<leader>Y', [["+Y]], { desc = 'Copy selection to clipboard' })
nnoremap('<leader>d', [["_d]], { desc = 'Delete selection to clipboard' })
vnoremap('<leader>d', [["_d]], { desc = 'Delete selection to clipboard' })

-- I don't know what this does it was in kickstart
nnoremap('<Space>', '<Nop>', silent)
vnoremap('<Space>', '<Nop>', silent)

-- Navigate properly through wrapped lines with j and k
nnoremap('k', "v:count == 0 ? 'gk' : 'k'", expr)
nnoremap('j', "v:count == 0 ? 'gj' : 'j'", expr)

-- Highlight the text that you yanked
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
