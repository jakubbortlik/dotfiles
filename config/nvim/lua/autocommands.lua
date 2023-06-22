-- Terminal autocommands
local id = vim.api.nvim_create_augroup("Terminal", {
  clear = false
})

-- always enter insert mode when switching to a terminal window
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  group = id,
  pattern = { "term://*", "\\[dap-repl\\]" },
  callback = function()
    vim.cmd [[startinsert]]
  end
})
-- always leave insert mode when switching from a terminal window
vim.api.nvim_create_autocmd({ "BufWinLeave", "WinLeave" }, {
  group = id,
  pattern = { "term://*", "\\[dap-repl\\" },
  callback = function()
    vim.cmd [[stopinsert]]
  end
})
-- don't show line numbers in a terminal window
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = id,
  pattern = { "term://*" },
  callback = function()
    vim.cmd [[setlocal listchars= nonumber norelativenumber]]
  end
})

-- vim: ts=2 sts=2 sw=2 et
