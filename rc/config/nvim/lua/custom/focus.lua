local map = require('utils').map

-- Zoom / Restore window.
local function FocusToggle()
    if vim.t.is_focused then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<c-w>=', true, false, true), 'm', true)
      vim.t.is_focused = false
    else
      vim.t.winrestcmd = vim.fn.winrestcmd()
      vim.cmd('resize')
      vim.cmd('vertical resize')
      vim.t.is_focused = true
    end
end

map('n', '<leader>z', '<cmd>lua require("custom.focus")()<cr>')

return FocusToggle
