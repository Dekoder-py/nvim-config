local key = vim.keymap

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- tmux-sessionizer
key.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- make
key.set("n", "<leader>mb", "<cmd>update<cr><cmd>make<cr>")
key.set("n", "<leader>mr", "<cmd>update<cr><cmd>make run<cr>")

-- explorer
key.set("n", "<leader>e", "<cmd>Ex<cr>")

-- buffers
key.set("n", "<leader>bd", "<cmd>bdelete<cr>")
key.set("n", "<leader>bn", "<cmd>bnext<cr>")
key.set("n", "<leader>bp", "<cmd>bprevious<cr>")

-- yank to sys. clipboard
key.set("n", "<leader>y", '"+y')
key.set("v", "<leader>y", '"+y')
key.set("n", "<leader>Y", '"+Y')
key.set("n", "<leader>p", '"+p')

-- search keeps result centered
key.set("n", "n", "nzzzv")
key.set("n", "N", "Nzzzv")

-- center bottom line
key.set("n", "G", "Gzz")

-- clear highlight
key.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- PLUGINS

-- Flash.nvim
key.set({ "n", "x", "o" }, "z", "<cmd>lua require(\"flash\").jump()<cr>")
key.set({ "n", "x", "o" }, "Z", "<cmd>lua require(\"flash\").treesitter()<cr>")
