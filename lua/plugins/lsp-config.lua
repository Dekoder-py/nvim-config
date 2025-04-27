return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ast_grep", "eslint", "html", "cssls", "bashls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.ast_grep.setup({})
      lspconfig.eslint.setup({})
      lspconfig.html.setup({})
      lspconfig.cssls.setup({})
      lspconfig.bashls.setup({})
      vim.lsp.config('lua_ls', {})
      vim.lsp.config('pyright', {})
      vim.lsp.config('ast_grep', {})
      vim.lsp.config('eslint', {})
      vim.lsp.config('html', {})
      vim.lsp.config('cssls', {})
      vim.lsp.config('bashls', {})
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('pyright')
      vim.lsp.enable('ast_grep')
      vim.lsp.enable('eslint')
      vim.lsp.enable('html')
      vim.lsp.enable('cssls')
      vim.lsp.enable('bashls')
      require("hover-fix")
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
      vim.diagnostic.config({
        signs = true,
        underline = true,
        update_in_insert = true,
        virtual_text = true,
        severity_sort = true,
      })
    end,
  },
}
