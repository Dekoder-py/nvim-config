return {
  "prichrd/netrw.nvim",
  opts = {},
  config = function()
    require("netrw").setup()
  end,
  keys = {
    {"<leader>e", "<cmd>Explore<cr>", desc = "Open Netrw"}
  } 
}
