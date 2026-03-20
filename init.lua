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
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines
vim.opt.wrap = false -- turn off wrapping
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open
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
vim.keymap.set("n", "<leader>x", "<cmd>restart<cr>") -- restart nvim
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
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- keep CTRL-d centered
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- keep CTRL-u centered
vim.keymap.set("n", "G", "Gzz") -- center bottom line
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- clear highlight
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false }) -- `jj` to exit insert mode
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<cr>") -- split vertically
vim.keymap.set("n", "<leader>sh", "<cmd>split<cr>") -- split horizontally
vim.keymap.set("n", "<C-h>", "<C-w>h") -- move to the left window
vim.keymap.set("n", "<C-j>", "<C-w>j") -- move to the down window
vim.keymap.set("n", "<C-k>", "<C-w>k") -- move to the up window
vim.keymap.set("n", "<C-l>", "<C-w>l") -- move to the right window
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<cr>") -- change window height
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<cr>") -- change window height
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>") -- change window width
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>") -- change window width
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==") -- move line down
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==") -- move line up
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move selection down
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move selection up
vim.keymap.set("v", ">", ">gv") -- indent left and reselect
vim.keymap.set("v", "<", "<gv") -- indent left and reselect

-- ================================
-- AUTOCMDS
-- ================================

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true} )

-- highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = augroup,
	callback = function()
		vim.highlight.on_yank()
	end,
}) 

-- wrap and spellcheck on md files
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end
})

-- ================================
-- PLUGINS (vim.pack)
-- ================================

local function packadd(name) 
  vim.cmd("packadd " .. name)
end

vim.pack.add({
  "https://github.com/wakatime/vim-wakatime",
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/rcarriga/nvim-notify",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/NeogitOrg/neogit",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/lewis6991/gitsigns.nvim",
})

packadd("vim-wakatime")
packadd("fzf-lua")
packadd("nvim-notify")
packadd("plenary.nvim")
packadd("neogit")
packadd("nvim-treesitter")
packadd("gitsigns.nvim")

-- ================================
-- PLUGINS (config)
-- ================================

-- Treesitter
local setup_treesitter = function()
  local treesitter = require("nvim-treesitter") 
  treesitter.setup({})
  local ensure_installed = {
    "vim",
    "vimdoc",
    "rust",
    "c",
    "cpp",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "astro",
    "svelte",
    "markdown",
    "bash",
    "python"
  }

  local config = require("nvim-treesitter.config")

  local already_installed = config.get_installed()
  local parsers_to_install = {}

  for _, parser in ipairs(ensure_installed) do
    if not vim.tbl_contains(already_installed, parser) then
      table.insert(parsers_to_install, parser)
    end
  end

  if #parsers_to_install > 0 then
		treesitter.install(parsers_to_install)
	end

  local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
				vim.treesitter.start(args.buf)
			end
    end,
	})
end

setup_treesitter()

-- FZF
require("fzf-lua").setup({})
vim.keymap.set("n", "<leader>ff", function()
  require("fzf-lua").files()
end)
vim.keymap.set("n", "<leader>fg", function()
  require("fzf-lua").live_grep()
end)
vim.keymap.set("n", "<leader>fb", function()
  require("fzf-lua").buffers()
end)
vim.keymap.set("n", "<leader>fh", function()
  require("fzf-lua").help_tags()
end)
vim.keymap.set("n", "<leader>fx", function()
  require("fzf-lua").diagnostics_document()
end)
vim.keymap.set("n", "<leader>fX", function()
  require("fzf-lua").diagnostics_workspace()
end)

-- Neogit
require("neogit").setup({})
vim.keymap.set("n", "<leader>g", "<cmd>Neogit<cr>")

-- Gitsigns
require("gitsigns").setup({})
