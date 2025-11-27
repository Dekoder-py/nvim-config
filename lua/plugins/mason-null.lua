return {
  "jay-babu/mason-null-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-null-ls").setup({
      ensure_installed = { "stylua", "black", "isort", "prettier", "shfmt", "alejandra", "clang-format" },
    })
  end,
}
