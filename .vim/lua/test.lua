local api = vim.api

local M = {}

function M.changeCase()
  res = string.gsub(vim.fn.expand("<cword>"), "_(.)", string.upper)
  print(res)
end

return M
