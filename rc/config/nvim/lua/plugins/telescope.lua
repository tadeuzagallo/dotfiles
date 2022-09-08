local telescope = require('telescope')
local utils = require('utils')

telescope.load_extension('fzf')

utils.map('n', '<leader>ff', ":lua require('telescope.builtin').find_files()<cr>")
utils.map('n', '<leader>fg', ":lua require('telescope.builtin').live_grep()<cr>")
