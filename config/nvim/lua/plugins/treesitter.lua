return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- PERF: no need to load the plugin, if we only need its queries for mini.ai
          local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
          local opts = require("lazy.core.plugin").values(plugin, "opts", false)
          local enabled = false
          if opts.textobjects then
            for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
              if opts.textobjects[mod] and opts.textobjects[mod].enable then
                enabled = true
                break
              end
            end
          end
          if not enabled then
            require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
          end
        end,
      },
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        -- "diff",
        "dockerfile",
        "gitcommit",
        "gitignore",
        "git_rebase",
        "html",
        "java",
        "javascript",
        "json",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "proto",
        "python",
        "r",
        "regex",
        "query",
        "sql",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      sync_install = false,
      highlight = {
        enable = true,
        -- Disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
      },
      indent = { enable = true, },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>", -- set to `false` to disable one of the mappings
          node_incremental = "<cr>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "HiPhish/nvim-ts-rainbow2",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function(_, _)
      require('nvim-treesitter.configs').setup {
        rainbow = {
          enable = true,
          query = 'rainbow-parens',
          strategy = require('ts-rainbow').strategy.global,  -- Highlight the entire buffer all at once
        },
      }
    end,
  }
}

-- vim: ts=2 sts=2 sw=2 et
