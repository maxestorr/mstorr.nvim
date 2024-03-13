# mstorr.nvim

My Neovim config.

## Includes:

- Basic config
    - [X] Sensible default options
    - [X] Sensible default remaps
- Essential features
    - [X] Color scheme
    - [X] Autocomplete (hrsh7th/nvim-cmp)
    - [X] LSP
        - Automatically install LSP clients (williamboman/mason)
        - Autolaunch an LSP client on filetype open (neovim/nvim-lspconfig)
        - Bridge the gap between mason and lspconfig (williamboman/mason-lspconfig)
    - [X] Treesitter (syntax map for other plugins to use)
        - [ ] Context (pin relavent context to first line)
        - [ ] Scope related movements (`vif` for visual select inner function)
    - [X] File explorer (Neo-Tree)
    - [X] Linter
    - [X] Formatter
    - [X] Undotree
- Nice to have features
    - [X] Telescope
    - [X] Harpoon
    - [X] Which-key
    - [X] Git signs
    - [X] Lazygit
    - [X] Git blame
    - [X] Status line (lualine)
        - [X] Show lazy plugins that need updating in lualine
    - [X] Make ui-select and ui-input use pretty inputs
        - Telescope plugin
        - Dressing.nvim
    - [X] Tmux resurrect should remember the nvim session
        - vim-prosession, search for sessions with <leader>sp
    - [X] Noice (nicer cmd input using floating window)
    - [X] rcarriga/nvim-notify
    - [X] mini.surround and mini.comment
        - [X] Surround plugin
        - [X] Comment plugin
    - [X] trouble.nvim, pretty list of:
        - Diagnostics
        - quickfix list
        - location list
    - [X] todo-comments.nvim
        - Adds todo and other comments to quickfix list
    - [X] Indent guide
        - indent-blankline for the guides
        - mini.indentscope for an animation that highlights scope
    - [X] Autopairs
    - [X] git-worktrees.nvim

