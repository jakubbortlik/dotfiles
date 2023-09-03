local M = {}

-- Return "main" or "master" for a git repository
local function get_main()
  local branch = vim.fn.system("git branch | sed 's/\\* //' | rg '^(main|master)$'")
  return branch
end

-- Simplify normal mode mappings
local nmap = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { desc = desc })
end

M.get_main = get_main
M.nmap = nmap

return M
