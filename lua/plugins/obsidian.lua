return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	ft = "markdown",
	---@module 'obsidian'
	---@type obsidian.config
	opts = {},
	config = function()
		require("obsidian").setup({
			workspaces = {
				{
					name = "Core",
					path = "~/vaults/Core/",
				},
			},
			templates = {
				subdir = "templates",
				date_format = "%d-%m-%Y",
				time_format = "%H:%M:%S",
			},
			ui = { enable = true },
			frontmatter = {
				enabled = false,
			},
		})
	end,
}
