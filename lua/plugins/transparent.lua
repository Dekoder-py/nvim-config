return {
  'xiyaowong/transparent.nvim',
  priority = 1000,
  config = function ()
    vim.keymap.set('n', '<leader>u', ':TransparentToggle<CR>', {})
    require('transparent').clear_prefix('NeoTree')
    require('transparent').clear_prefix('lualine')
  end
}
