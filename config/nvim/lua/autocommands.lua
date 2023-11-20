-- Terminal autocommands
local term_id = vim.api.nvim_create_augroup("Terminal", {
  clear = false
})

-- always enter insert mode when switching to a terminal window
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  group = term_id,
  pattern = { "term://*", "\\[dap-repl\\]" },
  callback = function()
    vim.cmd [[startinsert]]
  end
})
-- always leave insert mode when switching from a terminal window
vim.api.nvim_create_autocmd({ "BufWinLeave", "WinLeave" }, {
  group = term_id,
  pattern = { "term://*", "\\[dap-repl\\" },
  callback = function()
    vim.cmd [[stopinsert]]
  end
})
-- don't show line numbers in a terminal window
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = term_id,
  pattern = { "term://*" },
  callback = function()
    vim.cmd [[setlocal listchars= nonumber norelativenumber]]
  end
})

local python_id = vim.api.nvim_create_augroup("Python", {
  clear = false
})
vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  group = python_id,
  pattern = { "*py" },
  callback = function()
    vim.keymap.set("n", "<leader>ra", "<cmd>vnew term://python "..vim.fn.expand("%:p").."<cr>", { desc = "Run current file with Python" })
  end
})
