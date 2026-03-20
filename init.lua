-- ================================
-- init.lua - Kyle B, 20/03/2026 
-- ================================

-- ================================
-- OPTIONS
-- ================================

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


-- ================================
-- STATUSLINE
-- ================================

-- Git Branch
local cached_branch = ""
local last_check = 0
local function git_branch() 
  local now = vim.loop.now()
  if now - last_check > 5000 then
    cached_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
    last_check = now
  end
  if cached_branch ~= "" then
    return "\u{e725} " .. cached_branch .. " "
  end
  return ""
end

-- File Type
local function file_type()
  local ft = vim.bo.filetype
  local icons = {
		lua = "\u{e620} ",
		python = "\u{e73c} ",
		javascript = "\u{e74e} ",
		typescript = "\u{e628} ",
		javascriptreact = "\u{e7ba} ",
		typescriptreact = "\u{e7ba} ",
		html = "\u{e736} ",
		css = "\u{e749} ",
		scss = "\u{e749} ",
		json = "\u{e60b} ",
		markdown = "\u{e73e} ",
		vim = "\u{e62b} ",
		sh = "\u{f489} ",
		bash = "\u{f489} ",
		zsh = "\u{f489} ",
		rust = "\u{e7a8} ",
		go = "\u{e724} ",
		c = "\u{e61e} ",
		cpp = "\u{e61d} ",
		java = "\u{e738} ",
		php = "\u{e73d} ",
		ruby = "\u{e739} ",
		swift = "\u{e755} ",
		kotlin = "\u{e634} ",
		dart = "\u{e798} ",
		elixir = "\u{e62d} ",
		haskell = "\u{e777} ",
		sql = "\u{e706} ",
		yaml = "\u{f481} ",
		toml = "\u{e615} ",
		xml = "\u{f05c} ",
		dockerfile = "\u{f308} ",
		gitcommit = "\u{f418} ",
		gitconfig = "\u{f1d3} ",
		vue = "\u{fd42} ",
		svelte = "\u{e697} ",
		astro = "\u{e628} ",
  }

  if ft == "" then
    return " \u{f15b} "
  end

  return ((icons[ft] or " \u{f15b} ") .. ft)
end

local function file_size()
	local size = vim.fn.getfsize(vim.fn.expand("%"))
	if size < 0 then
		return ""
	end
	local size_str
	if size < 1024 then
		size_str = size .. "B"
	elseif size < 1024 * 1024 then
		size_str = string.format("%.1fK", size / 1024)
	else
		size_str = string.format("%.1fM", size / 1024 / 1024)
	end
	return " \u{f016} " .. size_str .. " " -- nf-fa-file_o
end

local function mode_icon()
	local mode = vim.fn.mode()
	local modes = {
		n = " \u{f121}  NORMAL",
		i = " \u{f11c}  INSERT",
		v = " \u{f0168} VISUAL",
		V = " \u{f0168} V-LINE",
		["\22"] = " \u{f0168} V-BLOCK",
		c = " \u{f120} COMMAND",
		s = " \u{f0c5} SELECT",
		S = " \u{f0c5} S-LINE",
		["\19"] = " \u{f0c5} S-BLOCK",
		R = " \u{f044} REPLACE",
		r = " \u{f044} REPLACE",
		["!"] = " \u{f489} SHELL",
		t = " \u{f120} TERMINAL",
	}
	return modes[mode] or (" \u{f059} " .. mode)
end

_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type
_G.file_size = file_size

vim.cmd([[
  highlight StatusLineBold gui=bold cterm=bold
]])

local function setup_dynamic_statusline()
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "#313244", fg = "#cdd6f4" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#181825", fg = "#585b70" }) -- inactive windows
  vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true, bg = "#313244", fg = "#cdd6f4" })

	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		callback = function()
			vim.opt_local.statusline = table.concat({
				"  ",
				"%#StatusLineBold#",
				"%{v:lua.mode_icon()}",
				"%#StatusLine#",
				" \u{e0b1} %f %h%m%r",
				"%{v:lua.git_branch()}",
				"\u{e0b1} ",
				"%{v:lua.file_type()}",
				" \u{e0b1} ",
				"%{v:lua.file_size()}",
				"%=",
				" \u{f017} %l:%c  %P ",
			})
		end,
	})
	vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
		callback = function()
			vim.opt_local.statusline = "  %f %h%m%r \u{e0b1} %{v:lua.file_type()} %=  %l:%c   %P "
		end,
	})
end

setup_dynamic_statusline()

-- ================================
-- KEYMAPS
-- ================================

vim.g.mapleader = " " -- leader key
vim.g.maplocalleader = "\\" -- local leader key
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>") -- tmux-sessionizer
vim.keymap.set("n", "<leader>r", "<cmd>update<cr><cmd>make!<cr>") -- run makeprg
vim.keymap.set("n", "<leader>R", ":set makeprg=") -- set makeprg
vim.keymap.set("n", "<leader>e", "<cmd>Ex<cr>") -- open netrw
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>") -- delete buffer
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>") -- next buffer
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>") -- previous buffer
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y') -- yank to system clipboard
vim.keymap.set("n", "n", "nzzzv") -- search keeps result centered
vim.keymap.set("n", "N", "Nzzzv") -- search keeps result centered
vim.keymap.set("n", "G", "Gzz") -- center bottom line
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- clear highlight
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false }) -- `jj` to exit insert mode
