require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'lua',
  },
  sync_install = false,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
}
