--- Source: https://github.com/zazencodes/dotfiles/blob/main/nvim/lua/workflows.lua
---
--------------
-- obsidian --
--------------
--
-- >>> oo # from shell, navigate to vault (optional)
--
-- # NEW NOTE
-- >>> on "Note Name" # call my "obsidian new note" shell script (~/bin/on)
-- >>>
-- >>> ))) <leader>on # inside vim now, format note as template
-- >>> ))) # add tag, e.g. fact / blog / video / etc..
-- >>> ))) # add hubs, e.g. [[python]], [[machine-learning]], etc...
-- >>> ))) <leader>of # format title
--
-- # END OF DAY/WEEK REVIEW
-- >>> or # review notes in inbox
-- >>>
-- >>> ))) <leader>ok # inside vim now, move to zettelkasten
-- >>> ))) <leader>odd # or delete
-- >>>
-- >>> og # organize saved notes from zettelkasten into notes/[tag] folders
--
-- navigate to vault
vim.keymap.set("n", "<leader>oo", ":cd /Users/kyle/vaults/Core/<cr>")
--
-- convert note to template and remove leading white space
vim.keymap.set("n", "<leader>on", ":Obsidian template note<cr>")
--
-- search for files in full vault
vim.keymap.set("n", "<leader>os", ":Telescope find_files search_dirs={\"/Users/kyle/vaults/Core/\"}<cr>")
vim.keymap.set("n", "<leader>oz", ":Telescope live_grep search_dirs={\"/Users/kyle/vaults/Core/\"}<cr>")
--
-- for review workflow
-- move file in current buffer to zettelkasten folder
vim.keymap.set("n", "<leader>ok", ":!mv '%:p' /Users/kyle/vaults/Core/zettelkasten<cr>:bd<cr>")
-- delete file in current buffer
vim.keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>")
