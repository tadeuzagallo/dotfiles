local map = require('utils').map
local fn = vim.fn

local function navigate(direction)
  local nr = fn.winnr()
  vim.cmd('wincmd ' .. direction)

  if nr == fn.winnr() then
    local nr = fn.tabpagenr()

    if direction == 'h' and nr > 1 then
      vim.cmd('tabprevious')
    elseif direction == 'l' and fn.tabpagewinnr(nr + 1) > 0 then
      vim.cmd('tabnext')
    end

    --if nr == fn.tabpagenr() then
      --local directionMap = {
        --h = 'Left',
        --j = 'Down',
        --k = 'Up',
        --l = 'Right',
      --}
      --local termDirection = directionMap[direction]
      --fn.system { '/Applications/WezTerm.app/Contents/MacOS/wezterm', 'cli', 'activate-pane-direction', termDirection }
    --end
  end
end

-- map('n', '<C-l><C-l>', '<cmd>lua require("custom.navigate")("p")<cr>') 
map('n', '<C-h>', '<cmd>lua require("custom.navigate")("h")<cr>')
map('n', '<C-j>', '<cmd>lua require("custom.navigate")("j")<cr>')
map('n', '<C-k>', '<cmd>lua require("custom.navigate")("k")<cr>')
map('n', '<C-l>', '<cmd>lua require("custom.navigate")("l")<cr>')

return navigate
