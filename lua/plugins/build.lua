return {
	"dekoder-py/build.nvim",
	event = { "DirChanged", "BufRead" },
	config = function()
		require("build").setup({})
	end,
}
