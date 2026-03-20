-----------------------------------
-- init.lua - Kyle B, 20/03/2026 --
-----------------------------------

-- =================
-- OPTIONS
-- =================

vim.opt.termguicolors = true -- use more colors
vim.g.have_nerd_font = true -- show nerd font icons
vim.cmd.colorscheme("catppuccin") -- the best colorscheme don't argue
vim.opt.winborder = "rounded" -- rounded border 
vim.opt.scrolloff = 10 -- keep 10 lines vertically on screen
vim.opt.sidescrolloff = 10 -- keep 10 lines horizontally on screen
vim.opt.colorcolumn = "120" -- show a line down screen on char pos 120
vim.cmd("set expandtab") -- use spaces instead of tabs
vim.cmd("set tabstop=2") -- tab width
vim.cmd("set softtabstop=2") -- soft tab stop not tabs on tab/bkspace
vim.cmd("set shiftwidth=2") -- indent width
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false }) -- `jj` to exit insert mode
vim.opt.number = true -- show line numbers
vim.opt.relativenumber = true -- line numbers relative to cursor
vim.opt.cursorline = true -- current line highlighted
vim.opt.signcolumn = "yes" -- space for signs like lsp and git stuff
vim.opt.showmode = false -- hide mode (custom statusline shows it)
vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- case sensitive when mixed case search
vim.opt.splitright = true -- split to the right
vim.opt.splitbelow = true -- split down
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
}) -- highlight on yank
vim.opt.wrap = false -- turn off wrapping
vim.opt.swapfile = false -- turn off swapfile
local undodir = vim.fn.expand("~/.vim/undodir")
if
  vim.fn.isdirectory(undodir) == 0 -- create dir if not exists
then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.undofile = true -- keep undo history
vim.opt.undodir = undodir -- set dir for undo history


