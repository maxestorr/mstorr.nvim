-- remaps.lua
--
-- Basic remaps for a better default experience
-- See `:help vim.keymap.set()`

-- Utility functions to reduce repetition of vim.keymap.set()
local Remap = require("keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap
local xnoremap = Remap.xnoremap
local tnoremap = Remap.tnoremap

local silent = { silent = true }
local expr = { expr = true }

inoremap("jk", "<esc>", { desc = "Exit insert mode" })

-- Easier window navigation
nnoremap("<C-L>", "<C-W><C-L>", { desc = "Select window right" })
nnoremap("<C-H>", "<C-W><C-H>", { desc = "Select window left" })
nnoremap("<C-K>", "<C-W><C-K>", { desc = "Select window up" })
nnoremap("<C-J>", "<C-W><C-J>", { desc = "Select window down" })

-- Keep window centered when navigating buffer
nnoremap("<C-d>", "<C-d>zz", { desc = "Down half page" })
nnoremap("<C-u>", "<C-u>zz", { desc = "Up half page" })
nnoremap("n", "nzzzv", { desc = "Next search item" })
nnoremap("N", "Nzzzv", { desc = "Previous search item" })

-- Keep cursor selection when joining or indenting
nnoremap("J", "mzJ`z", { desc = "Join selection with the next line" })
vnoremap(">", ">gv", { desc = "Indent selection" })
vnoremap("<", "<gv", { desc = "Dedent selection" })

vnoremap("J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vnoremap("K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

xnoremap("<leader>p", '"_dP', { desc = "Paste without overriding current buffer" })

nnoremap("<leader>y", [["+y]], { desc = "Copy selection to clipboard" })
vnoremap("<leader>y", [["+y]], { desc = "Copy selection to clipboard" })
nnoremap("<leader>Y", [["+Y]], { desc = "Copy selection to clipboard" })
nnoremap("<leader>d", [["_d]], { desc = "Delete selection to clipboard" })
vnoremap("<leader>d", [["_d]], { desc = "Delete selection to clipboard" })

-- <Space> is mapped to <Right> by default, unset this
nnoremap("<Space>", "<Nop>", silent)
vnoremap("<Space>", "<Nop>", silent)

-- Navigate properly through wrapped lines with j and k
nnoremap("k", "v:count == 0 ? 'gk' : 'k'", expr)
nnoremap("j", "v:count == 0 ? 'gj' : 'j'", expr)

