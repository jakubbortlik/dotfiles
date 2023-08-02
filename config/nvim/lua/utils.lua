local M = {}

-- Return "main" or "master" for a git repository
local function get_main()
  local branch = vim.fn.system("git branch | sed 's/\\* //' | rg '^(main|master)$'")
  return branch
end

M.get_main = get_main

return M
