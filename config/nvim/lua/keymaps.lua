local nmap = function(keys, func, desc)
  if desc then
    desc = "LSP: " .. desc
  end
  vim.keymap.set("n", keys, func, { desc = desc })
end

-- Override default behaviour
vim.keymap.set("n", "<C-e>", "3<C-E>", { desc = "Scroll down more" })
vim.keymap.set("n", "<C-y>", "3<C-Y>", { desc = "Scroll up more" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })
vim.keymap.set("n", "1<C-g>", "1<C-g>", { desc = "Print full path of current file name" }) -- Otherwise tmux-sessionizer is started

-- Navigation
vim.cmd [[let g:tmux_navigator_no_mappings = 1]]
vim.keymap.set("n", "<A-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true })
vim.keymap.set("n", "<A-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true })
vim.keymap.set("n", "<A-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true })
vim.keymap.set("n", "<A-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true })
vim.keymap.set("n", "<A-Bslash>", "<cmd>TmuxNavigatePrevious<cr>", { silent = true })
vim.keymap.set("t", "<A-h>", "<C-Bslash><C-n><C-W>h", { desc = "Navigate left" })
vim.keymap.set("t", "<A-j>", "<C-Bslash><C-n><C-W>j", { desc = "Navigate down" })
vim.keymap.set("t", "<A-k>", "<C-Bslash><C-n><C-W>k", { desc = "Navigate up" })
vim.keymap.set("t", "<A-l>", "<C-Bslash><C-n><C-W>l", { desc = "Navigate right" })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<A-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<A-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<A-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<A-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<A-w>', [[<C-\><C-n><C-w>]], opts)
end
vim.cmd('autocmd! TermOpen term:// lua set_terminal_keymaps()')

-- Mmiscellaneous mappings
vim.keymap.set({ "i", "n", "s", "v" }, "<C-s>", "<cmd>update<cr><esc>", { desc = "[s]ave file" })
vim.keymap.set("n", "co", "m`0:%s///gn<cr>", { desc = "[c]ount [o]ccurrences" })
vim.keymap.set("n", "cp", "m`:g//p<cr>", { desc = "print occurrences" })
vim.keymap.set("n", "<C-w>N", "<cmd>vnew<cr>", { desc = "Create new vertical window" })
vim.keymap.set("n", "<Leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear highlighting" })
vim.keymap.set("n", "<Leader>l", "<cmd>Lazy<cr>", { desc = "Show plugins" })

-- Greatest remaps ever, by ThePrimeagen
vim.keymap.set("x", "<Leader>p", [["_dP]], { desc = "Paster in Visual mode without losing the register" })
vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<Leader>Y", [["+Y]], { desc = "Add to system clipboard" })
vim.keymap.set({ "n", "v" }, "<Leader>d", [["_d]], { desc = "Delete to blackhole register" })
vim.keymap.set("n", "<Leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute word under cursor" })
vim.keymap.set("n", "<Leader>x", "<cmd>!chmod +x %<cr>", { silent = true, desc = "Make current file executable" })
vim.keymap.set("n", "<C-g>", "<cmd>silent !tmux neww tmux-sessionizer<cr>", { desc = "Create tmux session or attach to a an existing one" })
vim.keymap.set("n", "<Leader>u", "<cmd>UndotreeToggle<cr>", { desc = "Toggle UndoTree" })

-- Adjust textwidth
vim.keymap.set("n", "<Leader>w0", "<cmd>setlocal textwidth=0<cr>", { desc = "Set local textwidth to 0" })
vim.keymap.set("n", "<Leader>w7", "<cmd>setlocal textwidth=72<cr>", { desc = "Set local textwidth to 72" })
vim.keymap.set("n", "<Leader>w8", "<cmd>setlocal textwidth=80<cr>", { desc = "Set local textwidth to 80" })
vim.keymap.set("n", "<Leader>ww", "<cmd>setlocal textwidth=88<cr>", { desc = "Set local textwidth to 88" })

-- Wield the harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<Leader>a", mark.add_file, { desc = "Add file to Harpoon list" })
vim.keymap.set("n", "<C-h>", ui.toggle_quick_menu, { desc = "Open Harpoon quick menu" })
vim.keymap.set("n", "<C-j>", function() ui.nav_file(1) end, { desc = "Navigate to harpoon file 1" })
vim.keymap.set("n", "<C-k>", function() ui.nav_file(2) end, { desc = "Navigate to harpoon file 2" })
vim.keymap.set("n", "<C-l>", function() ui.nav_file(3) end, { desc = "Navigate to harpoon file 3" })
vim.keymap.set("n", "⁏", function() ui.nav_file(4) end, { desc = "Navigate to harpoon file 4" })

-- Diagnostic keymaps
nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
nmap("<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
nmap("<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")

-- Move cursor up and down in insert mode (useful in dap REPL)
vim.keymap.set("i", "<C-j>", "<Down>", { desc = "Move cursor down / Select next command", remap = true })
vim.keymap.set("i", "<C-k>", "<Up>", { desc = "Move cursor up / Select previous command", remap = true })

-- vim: ts=2 sts=2 sw=2 et
