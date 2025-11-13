return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup()
		if os.getenv("TMUX") then
			vim.defer_fn(function()
				vim.o.laststatus = 0
			end, 0)
		end
	end,
}
