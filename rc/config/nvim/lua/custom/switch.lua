local map = require('utils').map
local fn = vim.fn

-- switch between source and header
local function Switch()
  local file = fn.expand('%')
  local header_pattern = '\\.h\\(pp\\)\\{0,1}'
  local source_pattern = '\\(\\.c\\(c\\|pp\\)\\{0,1}\\|\\.m\\{1,2}\\)$'
  if fn.match(file, source_pattern) > 0 then
    local header = fn.substitute(file, source_pattern, '.h', '')
    vim.cmd('find ' .. header)
  elseif fn.match(file, header_pattern) > 0 then
    local source = fn.substitute(file, header_pattern, '.cpp', '')
    if fn.findfile(source) == "" then
      source = fn.substitute(file, header_pattern, '.c', '')
    end
    if fn.findfile(source) == "" then
      source = fn.substitute(file, header_pattern, '.cc', '')
    end
    if fn.findfile(source) == "" then
      source = fn.substitute(file, header_pattern, '.m', '')
    end
    if fn.findfile(source) == "" then
      source = fn.substitute(file, header_pattern, '.mm', '')
    end
    vim.cmd("edit " .. fn.findfile(source))
  end
end

map('n', '<leader><leader><tab>', '<cmd>lua require("custom.switch")()<cr>')

return Switch
