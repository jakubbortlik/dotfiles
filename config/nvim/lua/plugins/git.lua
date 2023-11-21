-- Git related plugins

local get_main = require("utils").get_main
local nmap = require("utils").nmap
local vmap = require("utils").vmap

local M = {
  {
    "tpope/vim-fugitive",
    keys = {
      { "<C-g><C-b>", "<cmd>Git blame<cr>", desc = "Run [G]it [b]lame"},
      { "<C-g><C-g>", "<cmd>Git<cr>", desc = "Run [G]it"},
      { "<C-g><C-d>", "<cmd>Gdiffsplit " .. get_main() .. "<cr>", desc = "[G][d]iffsplit with main"},
      { "<C-g><C-v>", "<cmd>Gvdiffsplit " .. get_main() .. "<cr>", desc = "[G][v]diffsplit with main"},
      { "<C-g>g", ":G ", desc = "Prepopulate commandline with :[G]it"},
      { "<C-g>d", ":Gdiffsplit ", desc = "Prepopulate commandline with [G][d]iffsplit"},
      { "<C-g>v", ":Gvdiffsplit ", desc = "Prepopulate commandline with [G][v]diffsplit"},
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
  },
  {
    "shumphrey/fugitive-gitlab.vim",
    cmd = {"GBrowse"},
    dependencies = {
      "tpope/vim-fugitive",
    },
    config = function()
      vim.g.fugitive_gitlab_domains = {"https://gitlab.cloud.phonexia.com"}
    end
  },
  {
    "tpope/vim-rhubarb",
    cmd = {"GBrowse"},
    dependencies = {
      "tpope/vim-fugitive",
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
          map("n", "]c", function()
            if vim.wo.diff then return "]c" end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then return "[c" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
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
      { "<leader>vc", "<cmd>DiffviewClose<cr>", desc = "Run Diff[v]iew[C]lose"},
      { "<leader>vH", ":DiffviewFileHistory ", desc = "Prepopulate commandline with Diff[v]iewFile[H]istory"},
      { "<leader>vh", "<cmd>DiffviewFileHistory %<cr>", desc = "Run Diff[v]iewFile[H]istory for current file"},
      { "<leader>vm", "<cmd>DiffviewOpen " .. get_main() .. "<cr>", desc = "Run Diff[v]iew[O]pen"},
      { "<leader>vo", ":DiffviewOpen ", desc = "Prepopulate commandline with Diff[v]iew[O]pen"},
      { "<leader>vr", "<cmd>DiffviewRefresh<cr>", desc = "Run Diff[v]iew[R]efresh"},
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
  {
    "rbong/vim-flog",
    dependencies = { "tpope/vim-fugitive" },
  },
  {
    "harrisoncramer/gitlab.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "stevearc/dressing.nvim",
    },
    build = function () require("gitlab.server").build(true) end, -- Builds the Go binary
    config = function()
      require("dressing").setup({
        input = {
          enabled = true
        }
      })
      local gitlab = require("gitlab")
      gitlab.setup({
        debug = { go_request = true, go_response = true }, -- Which values to log
        discussion_tree = {
          position = "bottom",
        },
      })
      nmap("glr", gitlab.review, "Gitlab Review")
      nmap("gls", gitlab.summary, "Gitlab Summary")
      nmap("glA", gitlab.approve, "Gitlab Approve")
      nmap("glR", gitlab.revoke, "Gitlab Revoke")
      nmap("glc", gitlab.create_comment, "Gitlab Create Comment")
      vmap("glc", gitlab.create_multiline_comment, "Gitlab Multiline Comment")
      vmap("gls", gitlab.create_comment_suggestion, "Gitlab Suggestion")
      nmap("gln", gitlab.create_note, "Gitlab Create note")
      nmap("gld", gitlab.toggle_discussions, "Gitlab Toggle Discussions")
      nmap("glaa", gitlab.add_assignee, "Gitlab Add Assignee")
      nmap("glad", gitlab.delete_assignee, "Gitlab Delete Assignee")
      nmap("glv", gitlab.add_reviewer, "Gitlab Add Reviewer")
      nmap("glV", gitlab.delete_reviewer, "Gitlab Delete Reviewer")
      nmap("glp", gitlab.pipeline, "Gitlab Pipeline")
      nmap("glo", gitlab.open_in_browser, "Gitlab Open in browser")
      nmap("glm", gitlab.move_to_discussion_tree_from_diagnostic, "Move to discussion")
    end,
  }
}

return M
