-- Defined leader before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.python3_host_prog = "/home/jakub/miniconda3/envs/neovim/bin/python3"

-- Setup colors before jellybeans is loaded
vim.g.jellybeans_use_term_background_color = 1
vim.g.jellybeans_use_term_italics = 1
vim.cmd [[ let g:jellybeans_overrides = {
\  "background": { "guibg": "NONE" },
\  "Folded": { "guibg": "NONE" },
\  "LineNr": { "guibg": "NONE" },
\  "Normal": { "guibg": "NONE" },
\  "SignColumn": { "guibg": "NONE" },
\  "Special": {"guifg": "c9dd9a",},
\}
]]

-- Install package manager:
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Specify setup options for lazy.nvim
local opts = {
  ui = {
    browser = "firefox",
  },
  checker = { enabled = true, frequency = 86400 }, -- Check for updates once a day
  performance = {
    rtp = {
      disabled_plugins = {
        "tohtml",
        "tutor",
      },
    },
  },
}

-- Install plugins:
require("lazy").setup("plugins", opts)
require("autocommands")
require("highlights")
require("keymaps")
require("options")

-- vim: ts=2 sts=2 sw=2 et
