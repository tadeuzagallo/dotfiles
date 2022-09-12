require('plugins')
require('options')
require('mappings')

-- configure plugins
require('plugins.telescope')
require('plugins.lualine')
require('plugins.nvim-cmp')
require('plugins.mason')
require('plugins.nvim-tree')

-- custom plugins
require('custom.navigate')
require('custom.switch')
require('custom.focus')
