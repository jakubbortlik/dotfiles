-- Lua version of "set 'option'"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.history = 10000
vim.o.wildmode = "longest,full"
vim.o.updatetime = 50
vim.o.mouse = ""
vim.opt.suffixes:remove {".info"}
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.showmode = false
vim.o.textwidth = 88
vim.o.colorcolumn = "+1"
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.completeopt = "menuone,longest,preview"
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.timeoutlen = 1500
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.spelllang = "en_us"
vim.o.fileformat = "unix"
vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
vim.o.scrolloff = 3
vim.o.signcolumn = "yes"

-- vim: ts=2 sts=2 sw=2 et
