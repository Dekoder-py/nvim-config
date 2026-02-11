-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- tmux-sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- make
vim.keymap.set("n", "<leader>r", "<cmd>make<cr>")

-- yank to sys. clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("n", "<leader>p", '"+p')

-- search keeps result centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- center bottom line
vim.keymap.set("n", "G", "Gzz")

-- clear highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
