-- FIX: Interesting issue:
-- Clone repo, then mv it to repo-old
-- Clone repo again to repo
-- Open repo in nvim, prosession forces nvim to open repo-old
-- Unsure why this is or how to fix it but there was no way save for manually deleting
-- ~/.vim/session/ to fix it. Maybe look into alternate plugin for more functionality
-- to manage sessions: https://github.com/rmagatti/auto-session
return {
    "dhruvasagar/vim-prosession",
    dependencies = {
        "tpope/vim-obsession",
    },
}
