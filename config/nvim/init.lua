-- Defined leader before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup colors before jellybeans is loaded
vim.g.jellybeans_use_term_background_color = 1
vim.g.jellybeans_use_term_italics = 1
vim.cmd [[ let g:jellybeans_overrides = {
\  "background": { "guibg": "NONE" },
\  "Folded": { "guibg": "NONE" },
\  "LineNr": { "guibg": "NONE" },
\  "Normal": { "guibg": "NONE" },
\  "SignColumn": { "guibg": "NONE" },
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

-- https://medium.com/linux-with-michael/lazy-nvim-the-blazingly-fast-neovim-package-manager-19a7a952835c
local opts = {
  ui = {
    browser = "firefox",
  },
  install = { colorscheme = { "tokyonight" } },
  checker = { enabled = true },
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
require("keymaps")
require("highlights")
require("options")

vim.cmd [[function! SynStack ()
  for i1 in synstack(line("."), col("."))
    let i2 = synIDtrans(i1)
    let n1 = synIDattr(i1, "name")
    let n2 = synIDattr(i2, "name")
    echo n1 "->" n2
  endfor
endfunction
nnoremap <leader>ss :echo SynStack()<cr>
]]

-- vim: ts=2 sts=2 sw=2 et
