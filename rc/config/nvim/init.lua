require('plugins')
require('options')
require('mappings')

-- configure plugins
require('plugins.telescope')
require('plugins.lualine')
require('plugins.mason')
require('plugins.nvim-tree')
require('plugins.treesitter')

-- custom plugins
require('custom.navigate')
require('custom.switch')
require('custom.focus')
