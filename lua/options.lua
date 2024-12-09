-- options.lua
--
-- Changing Neovim's option settings
-- See `:help vim.o`

local opt = vim.opt

opt.mouse = 'a'

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

opt.signcolumn = 'yes'
opt.colorcolumn = '80'
opt.laststatus = 3

opt.splitright = true
opt.splitbelow = true

opt.updatetime = 250
opt.timeoutlen = 300

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.completeopt = 'menuone,noselect'

opt.termguicolors = true

opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.list = true -- Show some invisible characters (tabs...

opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

