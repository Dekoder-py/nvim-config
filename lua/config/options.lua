-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- tmux-sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- tab settings
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- `jj` to exit insert
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false })

-- terminal stuff
vim.g.have_nerd_font = true
vim.o.termguicolors = true

-- keep lines on screen
vim.o.scrolloff = 10

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

-- line numbers and sign column
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- undo history
vim.opt.undofile = true

-- hide mode (using lualine instead)
vim.opt.showmode = false

-- smart case search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- split prefs
vim.opt.splitright = true
vim.opt.splitbelow = true

-- clear highlight
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- VIM
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- turn off wrapping
vim.opt.wrap = false

-- turn off swapfile
vim.opt.swapfile = false

-- obsidian
vim.opt.conceallevel = 2

vim.opt.winborder = "rounded"
