-- FIX: :ObsidianQuickSwitch is incredibly slow
--      Only the initial loading seems to take forever
--      After that searching is pretty quick
--      My vault isn't small but it's not large either
-- FIX: Error when launching nvim, can't find module obsidian
-- TODO: Install wsl-open https://gitlab.com/4U6U57/wsl-open

local vault_dir = "/mnt/c/Users/MaxStorr/obsidian-notes"

return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },

    -- ft = "markdown",
    event = {
        -- If you want to use the home shortcut o~' use the following
        -- `"BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"`
        "BufReadPre " .. vault_dir,
        "BufNewFile " .. vault_dir,
    },

    keys = {
        { "<Leader>so", ":ObsidianQuickSwitch<CR>", desc = "[S]earch [o]bsidian", silent = true },
    },

    opts = {

        workspaces = {
            -- You can set more than one vault, e.g. 'work' and 'personal'
            {
                name = "personal",
                path = vault_dir,
            },
        },

        templates = {
            subdir = "/_assets/templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
        },

        daily_notes = {
            folder = "/Daily Notes",
            date_format = "YYYY/MM-MMMM/YYYY-MM-DD dddd",
            alias_format = "%B %-d, %Y",
            template = "Daily Note Template.md",
        },

        attachments = {
            img_folder = "_assets/attachments",
        },

        mappings = {
            -- TODO: Include below mappings
            -- :ObsidianOpen
            -- :ObsidianToday
            -- :ObsidianLinks
            -- :ObsidianBackLinks
            -- :ObsidianPasteImg
            -- :ObsidianRename --dry-run
            -- :ObsidianExtractNote
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },

            ["<leader>ch"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
        },

        picker = {
            -- NOTE: Picker mappings are awesome!
            -- Maybe check out how to do this with other plugins
            name = "telescope.nvim",
            mappings = {
                new = "<C-x>",
                insert_link = "<C-l>",
            },
        },

        note_id_func = function(title)
            local suffix = ""
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
            end
            return tostring(os.time()) .. "-" .. suffix
        end,
    },
}
