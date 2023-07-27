-- Git related plugins

-- Return "main" or "master" for the repository
local function get_main()
  local branch = vim.fn.system("git branch | sed 's/\\* //' | rg '^(main|master)$'")
  return branch
end

local M = {
  {
    "tpope/vim-fugitive",
    keys = {
      { "<C-g><C-g>", "<cmd>Git<cr>", "Run [G]it"},
      { "<C-g><C-d>", "<cmd>Gdiffsplit " .. get_main() .. "<cr>", "[G][d]iffsplit with main"},
      { "<C-g><C-v>", "<cmd>Gvdiffsplit " .. get_main() .. "<cr>", "[G][v]diffsplit with main"},
      { "<C-g>g", ":G ", "Prepopulate commandline with :[G]it"},
      { "<C-g>d", ":Gdiffsplit ", "Prepopulate commandline with [G][d]iffsplit"},
      { "<C-g>v", ":Gvdiffsplit ", "Prepopulate commandline with [G][v]diffsplit"},
    },
    cmd = {
      "G",
      "GBrowse",
      "GDelete",
      "GMove",
      "GRemove",
      "GRename",
      "GUnlink",
      "Gcd",
      "Gclog",
      "Gdiffsplit",
      "Gdiffsplit",
      "Gdrop",
      "Gedit",
      "Ggrep",
      "Ghdiffsplit",
      "Git",
      "Glcd",
      "Glgrep",
      "Gllog",
      "Gpedit",
      "Gread",
      "Gsplit",
      "Gtabedit",
      "Gvdiffsplit",
      "Gvsplit",
      "Gwq",
      "Gwrite",
    },
    dependencies = {
      "shumphrey/fugitive-gitlab.vim",
      "tpope/vim-rhubarb",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        preview_config = {
          border = "rounded",
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          local wk = require("which-key")
          -- Register normal mode keymaps
          wk.register({
            h = {
              name = "git [h]unks", -- optional group name
              s = { gs.stage_hunk, "[s]tage" },
              r = { gs.reset_hunk, "[r]eset" },
              S = { gs.stage_buffer, "[S]tage buffer" },
              u = { gs.undo_stage_hunk, "[u]ndo stage" },
              R = { gs.reset_buffer, "[R]eset buffer" },
              p = { gs.preview_hunk, "[p]review" },
              b = { function() gs.blame_line { full = true } end, "[b]lame line" },
              t = { gs.toggle_current_line_blame, "[t]oggle line blame" },
              d = { gs.diffthis, "[d]iff this" },
              D = { function() gs.diffthis('~') end, "[D]iff this agains '~'" },
              T = { gs.toggle_deleted, "[T]oggle deleted" },
            },
          }, { prefix = "<leader>" })
          -- Register visual mode keymaps
          wk.register({
            h = {
              name = "git [h]unks", -- optional group name
              s = { function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "[s]tage" },
              r = { function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "[r]eset" },
            },
          }, { prefix = "<leader>", mode = "v" })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      })
    end,
  },
  {
    "sindrets/diffview.nvim", -- a single tabpage interface for reviewing all git changes
    keys = {
      { "<leader>vc", "<cmd>DiffviewClose<cr>", "Run Diff[v]iew[C]lose"},
      { "<leader>vh", "<cmd>DiffviewFileHistory<cr>", "Run Diff[v]iewFile[H]istory"},
      { "<leader>vm", "<cmd>DiffviewOpen main<cr>", "Run Diff[v]iew[O]pen"},
      { "<leader>vo", ":DiffviewOpen ", "Run Diff[v]iew[O]pen"},
      { "<leader>vr", "<cmd>DiffviewRefresh<cr>", "Run Diff[v]iew[R]efresh"},
    },
    cmd = {
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewLog",
      "DiffviewOpen",
      "DiffviewRefresh",
      "DiffviewToggleFiles",
    },
    config = function()
      require("diffview").setup({
        commit_log_panel = {
          win_config = function()
            return { type = "float", border = "rounded", }
          end
        }
      })
    end,
  },
}

return M
