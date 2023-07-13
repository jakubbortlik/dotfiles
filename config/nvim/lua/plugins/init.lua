return {
  -- "A universal set of defaults"
  "tpope/vim-sensible",

  -- Plugin for (not only) vimscript plugins
  {
    "tpope/vim-scriptease",
    keys = { { "zS" }, { "K" }, },
    cmd = { "Messages", "PP", "Scriptnames", "Verbose", "Time" },
  },


  -- Plugins for enhanced editing
  "tpope/vim-repeat", -- Repeat other plugins with . command
  "tpope/vim-rsi",    -- Emulate Readline key bindings
  {
    "tpope/vim-capslock",
    keys = {
      { "<C-G>c", mode = "i", desc = "Temporarily toggle caps lock" },
      { "gC",     mode = "n", desc = "Toggle caps lock" },
    },
  },
  "tommcdo/vim-exchange",    -- Easy exange of two portions of text
  {
    "numToStr/Comment.nvim", -- Toggle comments
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
      { mode = "i", "<C-k><C-j>", desc = "Next keymap" },
      { mode = "i", "<C-k><C-k>", desc = "Previous keymap" },
      { mode = "i", "<C-k><C-l>", desc = "Show keymaps" },
    },
  },
  {
    "mbbill/undotree", -- Show undo history in a tree
    keys = { { "<Leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" } },
    config = function()
      vim.g.undotree_WindowLayout = 2
    end,
  },
  {
    "simnalamburt/vim-mundo",
    keys = { { "<Leader>U", "<cmd>MundoToggle<cr>", desc = "Toggle Mundo Tree" } },
    config = function()
      vim.g.mundo_preview_bottom = 1
      vim.g.mundo_verbose_graph = 0
    end,
  },
  {
    "vim-scripts/bash-support.vim",
    ft = "sh",
  },
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
    config = true,
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
      -- temporary fix of wrong temporary cursor
      vim.api.nvim_create_autocmd(
        "User",
        {
          callback = function()
            vim.cmd.hi("Cursor", "blend=100")
            vim.opt.guicursor:append { "a:Cursor/lCursor" }
          end,
          pattern = "LeapEnter"
        }
      )
      vim.api.nvim_create_autocmd(
        "User",
        {
          callback = function()
            vim.cmd.hi("Cursor", "blend=0")
            vim.opt.guicursor:remove { "a:Cursor/lCursor" }
          end,
          pattern = "LeapLeave"
        }
      )
    end,
  },
  {
    "ggandor/flit.nvim",
    config = function()
      require("flit").setup(
        {
          clever_repeat = false,
        }
      )
    end,
  },

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
    'm-demare/hlargs.nvim',
    config = function()
      require("hlargs").setup({
        color = "#5fafff",
        excluded_argnames = {
          declarations = {
            python = { 'self', 'cls' },
            lua = { 'self' }
          },
          usages = {
            python = { 'self', 'cls' },
            lua = { 'self' }
          }
        },
      })
    end,
  },
  {
    "RRethy/vim-illuminate", -- Highlight references
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 0,
      providers = { "lsp", "treesitter", "regex" },
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "regex" },
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
      require("hlslens").setup() -- is not required
      require("scrollbar.handlers.search").setup({
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        char = "┆",
        char_highlight_list = { "IndentBlanklineIndent1" },
        show_trailing_blankline_indent = false,
      })
    end,
  },

  { dir = "~/projects/vim-phxstm", ft = "phxstm" },
}
