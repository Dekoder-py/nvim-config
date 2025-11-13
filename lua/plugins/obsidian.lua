return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	ft = "markdown",
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
		workspaces = {
			{
				name = "Second Brain",
				path = "~/Second Brain/",
			},
		},
	},
	ui = { enable = true },
}
