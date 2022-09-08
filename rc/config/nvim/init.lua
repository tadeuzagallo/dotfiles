require('plugins')
require('options')
require('mappings')

-- configure plugins
require('plugins.telescope')
require('plugins.lualine')
require('plugins.cmp-nvim-lsp')
require('plugins.nvim-cmp')
require('plugins.mason')

-- custom plugins
require('custom.navigate')
require('custom.switch')
require('custom.focus')
