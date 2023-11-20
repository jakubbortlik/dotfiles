M = {
  {
    "folke/which-key.nvim", -- Show pending keybinds
    event = "VeryLazy",
    opts = {
      window = {
        border = "rounded",
      },
    }
  },
}

local nmap = require("utils").nmap

-- Override default behaviour
nmap("<C-e>", "3<C-E>", "Scroll down more")
nmap("<C-y>", "3<C-Y>", "Scroll up more")
nmap("J", "mzJ`z", "Join lines without moving cursor")
nmap("1<C-g>", "1<C-g>", "Print full path of current file name") -- Otherwise tmux-sessionizer is started

-- Navigation
vim.cmd [[let g:tmux_navigator_no_mappings = 1]]
vim.keymap.set({"n", "t"}, "<A-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true, desc = "Navigate left" })
vim.keymap.set({"n", "t"}, "<A-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true, desc = "Navigate down" })
vim.keymap.set({"n", "t"}, "<A-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true, desc = "Navigate up" })
vim.keymap.set({"n", "t"}, "<A-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true, desc = "Navigate right" })
vim.keymap.set("n", "t<c-]>", "<cmd>tab split | execute 'normal <c-]>'<cr>", { silent = true, desc = "Jump to definition in new tab." })

-- Miscellaneous mappings
vim.keymap.set({ "i", "n", "s", "v" }, "<C-s>", "<cmd>update<cr><esc>", { desc = "[s]ave file" })
nmap("co", "m`0:%s///gn<cr>", "[c]ount [o]ccurrences")
nmap("cp", "m`:g//p<cr>", "o[c]currences [p]review")
nmap("<C-w>N", "<cmd>vnew<cr>", "Create [N]ew vertical window")
nmap("<Leader>ch", "<cmd>nohlsearch<cr>", "[c]lear [h]ighlighting")
nmap("<Leader>l", "<cmd>Lazy<cr>", "Show plugins")
nmap("<leader>i", "<cmd>Inspect<cr>", "[i]nspect current position")
nmap("<leader>sa", [[:s/\%>.c]], "[s]ubstitute [a]fter")
nmap("<Leader>su", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "[s]ubstitute word [u]nder cursor")
nmap("<Leader>cp", [[<cmd>let @+ = expand('%') | echo "Copied to clipboard: " .. @+<cr>]], "[c]opy [p]ath of buffer to clipboard")
nmap("<Leader>cP", [[<cmd>let @+ = expand('%:p') | echo "Copied to clipboard: " .. @+<cr>]], "[c]opy full [P]ath of buffer to clipboard")
nmap("<Leader>c<c-p>", [[<cmd>let @+ = expand('%:t') | echo "Copied to clipboard: " .. @+<cr>]], "[c]opy basename of buffer to clipboard")
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {desc = "Exit terminal-mode"})
nmap("<BS>", "<Del>", "Delete the last digit when entering a number.")

-- TODO: add check that an LSP server is actually attached
nmap("<leader>L", "<cmd>vertical Verbose lua =vim.lsp.get_active_clients()[1].server_capabilities<cr>", "print [L]SP server capabilities")

-- Greatest remaps ever, by ThePrimeagen
vim.keymap.set("x", "<Leader>p", [["_dP]], { desc = "Visual mode paste without losing register" })
vim.keymap.set({ "n", "v" }, "<Leader>y", [["+y]], { desc = "Copy to system clipboard" })
nmap("<Leader>Y", [["+Y]], "Add to system clipboard")
vim.keymap.set({ "n", "v" }, "<Leader>d", [["_d]], { desc = "Delete to blackhole register" })
vim.keymap.set("n", "<Leader>x", "<cmd>!chmod +x %<cr>", { silent = true, desc = "Make current file executable" })
nmap("<C-g><C-s>", "<cmd>silent !tmux neww tmux-sessionizer<cr>", "Create tmux [s]ession or attach to one")

-- Adjust textwidth
nmap("<Leader>w0", "<cmd>setlocal textwidth=0<cr>", "Set local text[w]idth to [0]" )
nmap("<Leader>w7", "<cmd>setlocal textwidth=72<cr>", "Set local text[w]idth to [7]2" )
nmap("<Leader>w8", "<cmd>setlocal textwidth=88<cr>", "Set local text[w]idth to [8]8" )
nmap("<Leader>w9", "<cmd>setlocal textwidth=90<cr>", "Set local text[w]idth to [9]0" )
nmap("<Leader>w1", "<cmd>setlocal textwidth=100<cr>", "Set local text[w]idth to [1]00" )

-- Wield the harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
nmap("<Leader>a", mark.add_file, "Add file to Harpoon list")

local toggle_relative_quick_menu = function()
  require("harpoon").setup({
    menu = {
      width = math.floor(vim.api.nvim_win_get_width(0) * 0.75),
    }
  })
  ui.toggle_quick_menu()
end

nmap("<C-h>", toggle_relative_quick_menu, "Open Harpoon quick menu")

nmap("<C-j>", function() ui.nav_file(1) end, "Navigate to harpoon file 1")
nmap("<C-k>", function() ui.nav_file(2) end, "Navigate to harpoon file 2")
nmap("<C-l>", function() ui.nav_file(3) end, "Navigate to harpoon file 3")
nmap("⁏", function() ui.nav_file(4) end, "Navigate to harpoon file 4")
nmap("<C-;>", function() ui.nav_file(4) end, "Navigate to harpoon file 4")

-- Diagnostic keymaps
nmap("[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
nmap("]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
nmap("<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
nmap("<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")

return M
