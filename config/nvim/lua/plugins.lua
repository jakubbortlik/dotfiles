return {
  -- "A universal set of defaults"
  "tpope/vim-sensible",

  -- Git related plugins
  "tpope/vim-fugitive",
  -- "tpope/vim-rhubarb",

  -- Plugins for enhanced editing
  "tpope/vim-repeat",      -- Repeat other plugins with . command
  "tpope/vim-rsi",         -- Emulate Readline key bindings
  "tpope/vim-capslock",
  "tommcdo/vim-exchange",  -- Easy exange of two portions of text
  "b3nj5m1n/kommentary",   -- Toggle comments
  {
    "tpope/vim-speeddating", -- Let <C-A>, <C-X> work on dates properly
    keys = {
      { "<C-a>", mode = { "n", "v" }, desc = "Increment component under cursor" },
      { "<C-x>", mode = { "n", "v" }, desc = "Decrement component under cursor" },
    },
    cmd = "SpeedDatingFormat",
  },
  "tpope/vim-surround",  -- Parentheses, brackets, quotes, and more
  "tpope/vim-unimpaired", -- Pairs of handy bracket mappings
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
        "<Leader>ir",
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Incremental [R]ename",
      },
    },
    config = true,
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

  --[[ -- Must be loaded before nvim-treesitter
  "HiPhish/nvim-ts-rainbow2", ]]

  -- Plugin for vimscript plugins
  "tpope/vim-scriptease",

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

  -- Colorscheme, highlighting and other visual stuff
  {
    "nanotech/jellybeans.vim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("jellybeans")
    end,
  },
  "machakann/vim-highlightedyank",
  "vim-scripts/FastFold",
  "tmhedberg/SimpylFold",
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
  { "akinsho/toggleterm.nvim",     version = "*", config = true },

  -- Show pending keybinds
  { "folke/which-key.nvim",        opts = {} },

  { dir = "~/projects/vim-phxstm", ft = "phxstm" },
}

-- vim: ts=2 sts=2 sw=2 et
