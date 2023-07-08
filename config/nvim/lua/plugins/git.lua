local M = {
  -- Git related plugins
  {
    "tpope/vim-fugitive",
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
    lazy = true,
    dependencies = "tpope/vim-fugitive",
  },
  {
    "tpope/vim-rhubarb",
    lazy = true,
    dependencies = "tpope/vim-fugitive",
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
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

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk, { desc = "[H]unk [s]tage" })
          map('n', '<leader>hr', gs.reset_hunk, { desc = "[H]unk [r]eset" })
          map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = "[H]unk [s]tage" })
          map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { desc = "[H]unk [r]eset" })
          map('n', '<leader>hS', gs.stage_buffer, { desc = "[H]unk [S]tage buffer" })
          map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "[H]unk [u]ndo stage" })
          map('n', '<leader>hR', gs.reset_buffer, { desc = "[H]unk [R]eset buffer" })
          map('n', '<leader>hp', gs.preview_hunk, { desc = "[H]unk [p]review" })
          map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "[H]unk [b]lame line" })
          map('n', '<leader>ht', gs.toggle_current_line_blame, { desc = "[H]unk [t]oggle line blame" })
          map('n', '<leader>hd', gs.diffthis, { desc = "[H]unk [d]iff this" })
          map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "[H]unk [D]iff this agains '~'" })
          map('n', '<leader>hT', gs.toggle_deleted, { desc = "[H]unk [T]oggle deleted" })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      })
    end,
  },

}

return M
