local api = vim.api

local M = {}

function M.makeScratch()
  api.nvim_command("enew")
end

return M
