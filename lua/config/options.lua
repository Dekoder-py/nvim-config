-- OPTIONS FOR VIM

-- set tabs to 2 spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- exit insert with `jj`
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false })

-- nerd font & colors
vim.g.have_nerd_font = true
vim.opt.termguicolors = true

-- folding
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- keep at least 10 lines when scrolling
vim.opt.scrolloff = 10

-- yank to system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("n", "<leader>p", '"+p')

-- center screen during search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- sign column
vim.opt.signcolumn = "yes"

-- save undo history
vim.opt.undofile = true

-- smart case search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- split prefs
vim.opt.splitright = true
vim.opt.splitbelow = true

-- clear highlight from search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- highlight briefly on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- turn off wrapping 
vim.opt.wrap = false

-- turn off swapfile
vim.opt.swapfile = false
