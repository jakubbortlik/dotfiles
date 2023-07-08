return {
  -- "A universal set of defaults"
  "tpope/vim-sensible",

  -- Plugins for enhanced editing
  "tpope/vim-repeat",        -- Repeat other plugins with . command
  "tpope/vim-rsi",           -- Emulate Readline key bindings
  {
    "tpope/vim-capslock",
    keys = {
      { "<C-G>c", mode = "i", desc = "Temporarily toggle caps lock" },
      { "gC", mode = "n", desc = "Toggle caps lock" },
    },
  },
  "tommcdo/vim-exchange",    -- Easy exange of two portions of text
  {
    "numToStr/Comment.nvim",   -- Toggle comments
    config = true,
  },
  {
    "tpope/vim-speeddating", -- Let <C-A>, <C-X> work on dates properly
    keys = {
      { "<C-a>", mode = { "n", "v" }, desc = "Increment component under cursor" },
      { "<C-x>", mode = { "n", "v" }, desc = "Decrement component under cursor" },
    },
    cmd = "SpeedDatingFormat",
  },
  "tpope/vim-surround",    -- Parentheses, brackets, quotes, and more
  "tpope/vim-unimpaired",  -- Pairs of handy bracket mappings
  {
    "vim-scripts/VisIncr", -- In/decreasing columns of Ns and dates
    cmd = {
      "I",
      "IA",
      "IB",
      "ID",
      "IDMY",
      "IIB",
      "IIO",
      "IIPOW",
      "IIR",
      "IIX",
      "IM",
      "IMDY",
      "IO",
      "IPOW",
      "IR",
      "IX",
      "IYMD",
    },
  },
  {
    "mechatroner/rainbow_csv", -- Show tabulated data in colour
    ft = { "csv", "tsv", "txt" },
  },
  {
    "jakubbortlik/vim-keymaps", -- Switch keyboard layouts
    keys = {
      { "ckj", desc = "Next keymap" },
      { "ckk", desc = "Previous keymap" },
      { "ckl", desc = "Show keymaps" },
    },
  },
  "mbbill/undotree", -- Show undo history in a tree
  "vim-scripts/bash-support.vim",
  {
    "vim-scripts/linediff.vim", -- Diff two different parts of the same file
    cmd = "Linediff",
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
  },
  {
    "smjonas/inc-rename.nvim", -- Rename with preview
    keys = {
      {
        "<Leader>ri",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "[R]ename [I]ncrementally",
      },
    },
    config = true,
  },
  {
    "tversteeg/registers.nvim",
    name = "registers",
    keys = {
      { '"',     mode = { "n", "v" } },
      { "<C-R>", mode = "i" },
    },
    cmd = "Registers",
    config = function()
      require("registers").setup({
        show_empty = false,
      })
    end,
  },
  {
    'gerazov/toggle-bool.nvim',
    keys = { "cm" },
    config = function()
      require("toggle-bool").setup({
        mapping = "cm",
        description = "Toggle bool value",
        additional_toggles = {
          Yes = 'No',
          On = 'Off',
          ["0"] = "1",
          Enable = 'Disable',
          Enabled = 'Disabled',
          First = 'Last',
          before = 'after',
          Before = 'After',
          Persistent = 'Ephemeral',
          Internal = 'External',
          Ingress = 'Egress',
          Allow = 'Deny',
          All = 'None',
        },
      })
    end
  },

  -- Navigation
  {
    "tpope/vim-vinegar", -- Enhanced netrw
    keys = { "-" },
  },
  {
    "ThePrimeagen/harpoon", -- Navigate inside projects
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "christoomey/vim-tmux-navigator", -- Navigate easily in vim and tmux
    cmd = {
      "TmuxNavigateDown",
      "TmuxNavigateLeft",
      "TmuxNavigatePrevious",
      "TmuxNavigateRight",
      "TmuxNavigateUp",
    },
  },
  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "ggandor/flit.nvim",
    config = function()
      require("flit").setup()
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      {
        "<leader>t",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = true,
        hijack_netrw_behavior = "disabled",
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = { "toggle_node", nowait = true },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "",    -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "✖", -- this can only be used in the git_status source
            renamed = "", -- this can only be used in the git_status source
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },
    },
    config = function(_, opts)
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },

  -- Plugin for vimscript plugins
  "tpope/vim-scriptease",

  -- Language specific plugins
  {
    "alunny/pegjs-vim",
    ft = "pegjs",
  },

  -- Unicode tables and digraphs expansion
  {
    "chrisbra/unicode.vim",
    config = function()
      vim.g.Unicode_no_default_mappings = true
    end,
    keys = {
      { "ga",         "<Plug>(UnicodeGA)",       mode = "n", desc = "Get detailed Unicode info" },
      { "<C-x><C-g>", "<Plug>(DigraphComplete)", mode = "i", desc = "Complete Digraph before cursor" },
    },
    cmd = "UnicodeTable",
  },

  -- highlighting and other visual stuff
  "machakann/vim-highlightedyank",
  -- TODO: figure out how to disable folding upon enteing the window
  --[[ {
    "tmhedberg/SimpylFold",
    dependencies = {
      "Konfekt/FastFold",
    },
    config = function()
      vim.keymap.set("n", "zuz", "<Plug>(FastFoldUpdate)<cr>", { desc = "Update folds" })
      vim.g.SimpylFold_fold_dosctring = 0
      vim.g.SimpylFold_fold_import = 0
    end
  }, ]]
  {
    "RRethy/vim-illuminate", -- Highlight references
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 0,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    config = true,
  },
  {
    "kevinhwang91/nvim-hlslens",
    dependencies = "petertriho/nvim-scrollbar",
    config = function()
      require("hlslens").setup()  -- is not required
      require("scrollbar.handlers.search").setup({
      })
    end,
  },

  { dir = "~/projects/vim-phxstm", ft = "phxstm" },
}

-- vim: ts=2 sts=2 sw=2 et
