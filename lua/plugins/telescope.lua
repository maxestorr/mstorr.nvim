return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",

        -- FIX: After using clone-bare to clone a repo, new branches don't appear to update properly
        -- and throw a git error
        "ThePrimeagen/git-worktree.nvim",
        "dhruvasagar/vim-prosession", -- Search vim sessions
        "stevearc/dressing.nvim", -- Make vim.ui-select/input use telescope
        "nvim-telescope/telescope-live-grep-args.nvim",
    },

    config = function()
        local keymap = vim.keymap
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local telescopeConfig = require("telescope.config")
        local lga_actions = require("telescope-live-grep-args.actions")

        -- Clone the default Telescope configuration
        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

        -- I want to search in hidden/dot files.
        table.insert(vimgrep_arguments, "--hidden")
        -- I don't want to search in the `.git` directory.
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")

        -- TODO: Include .*env files in this ignore list
        telescope.setup({
            defaults = {
                -- `hidden = true` is not supported in text grep commands.
                vimgrep_arguments = vimgrep_arguments,
            },
            pickers = {
                find_files = {
                    -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    -- define mappings, e.g.
                    mappings = { -- extend mappings
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt(),
                            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            -- freeze the current list and start a fuzzy search in the frozen list
                            ["<C-space>"] = lga_actions.to_fuzzy_refine,
                        },
                    },
                },
            },
        })

        keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch for [f]iles" })
        -- TODO: Workout why this fails using the builtin method
        keymap.set(
            "n",
            "<leader>sF",
            ":lua require('telescope.builtin').find_files({hidden=true, no_ignore=true})<cr>",
            { desc = "[S]earch for all [F]iles" }
        )
        keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch via [g]rep" })
        keymap.set("n", "<leader>sG", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
        keymap.set("n", "<leader>sm", builtin.man_pages, { desc = "[S]earch [m]an pages" })
        keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [h]elp files" })
        keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [b]uffers" })
        keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [k]eymaps" })
        keymap.set(
            "n",
            "<leader>sp",
            ":Telescope prosession<CR>",
            { desc = "[S]earch vim [p]rosessions", silent = true }
        )
        keymap.set(
            "n",
            "<leader>sr",
            ":lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
            { desc = "[S]earch git wo[r]ktrees", silent = true }
        )
        keymap.set(
            "n",
            "<leader>sR",
            ":lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
            { desc = "Create git wo[R]ktrees", silent = true }
        )
        -- <Enter> - switches to that worktree
        -- <c-d> - deletes that worktree
        -- <c-f> - toggles forcing of the next deletion

        telescope.load_extension("fzf")
        telescope.load_extension("prosession")
        telescope.load_extension("git_worktree")
        telescope.load_extension("live_grep_args")
    end,
}
