-- Lua version of "set 'option'"
vim.opt.backup = false
vim.opt.colorcolumn = "+1"
vim.opt.completeopt = "menuone,longest,preview"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fileformat = "unix"
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.hlsearch = false
vim.opt.history = 10000
vim.opt.ignorecase = true
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.softtabstop = 4
vim.opt.spelllang = "en_us"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.suffixes:remove {".info"}
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.termguicolors = true
vim.opt.textwidth = 88
vim.opt.timeoutlen = 500
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.wildmode = "longest,full"

-- vim: ts=2 sts=2 sw=2 et
